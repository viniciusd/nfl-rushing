import React from "react";
import axios from "axios";
import Filter from "./Filter";
import Pagination from "./Pagination";
import Table from "./Table";
import "bootstrap/dist/css/bootstrap.css";

async function fetchRecords(url) {
  const resp = await axios.get(url);
  return resp.data;
}

function updateQueryParams(requestUrl, updateParams) {
  let url = new URL(requestUrl);
  const params = new URLSearchParams(url.search);

  for (const key of Object.keys(updateParams)) {
    if (updateParams[key] === null) {
      params.delete(key);
    } else {
      params.set(key, updateParams[key]);
    }

    url.search = params;
    return new URL(url.toString());
  }
}
function App() {
  const headers = [
    "Player",
    "Team",
    "Pos",
    "Att",
    "Att/G",
    "Yds",
    "Avg",
    "Yds/G",
    "TD",
    "Lng",
    "1st",
    "1st%",
    "20+",
    "40+",
    "FUM"
  ];

  const [records, setRecords] = React.useState([]);
  const [requestUrl, setRequestUrl] = React.useState(
    "http://localhost:5000/api/players"
  );
  const [pagination, setPagination] = React.useState({
    next: "",
    previous: ""
  });
  const [sorting, setSorting] = React.useState({
    columns: ["Yds", "Lng", "TD"],
    order: "asc",
    by: null
  });
  const [filter, setFilter] = React.useState("");
  const [error, setError] = React.useState("");

  function previousPage() {
    setRequestUrl(pagination.previous);
  }

  function nextPage() {
    setRequestUrl(pagination.next);
  }

  const setQueryParams = (params) => {
	  const url = updateQueryParams(requestUrl, params);
	  console.log(requestUrl, params, url);

	  setRequestUrl(url);
  }

  function sortBy(header) {
    return () => {
      if (sorting.columns.includes(header)) {
        let order;
        if (sorting.order === null || sorting.by !== header) {
          order = "desc";
        } else if (sorting.order === "desc") {
          order = "asc";
        } else if (sorting.order === "asc") {
          order = null;
        }

        setSorting({
          ...sorting,
          by: order !== null ? header : null,
          order: order
        });
      }
    };
  }

  React.useEffect(() => {
    setQueryParams({ filter: filter || null });
  }, [filter]);

  React.useEffect(() => {
    setQueryParams({
      sort: sorting.by || null,
      order: sorting.order || null
    });
  }, [sorting]);

  React.useEffect(() => {
    async function fetchData() {
      try {
        const records = await fetchRecords(requestUrl);
        setRecords(records.data);
        setPagination({
          previous:
            records["_links"]["prev"] && records["_links"]["prev"]["href"],
          next: records["_links"]["next"]["href"]
        });
      } catch (err) {
        setError(err.message);
      }
    }
    fetchData();
  }, [requestUrl]);

  return (
    <div className="App">
      <header className="App-header">
        {error && <span>{error}</span>}
        <div className="p-4">
          <Filter onChangeCallback={setFilter} />
        </div>
        <Table
          sortBy={sortBy}
          sorting={sorting}
          headers={headers}
          records={records}
        />
        <Pagination
          disablePrevious={!pagination.previous}
          previousPageCallback={previousPage}
          nextPageCallback={nextPage}
        />
      </header>
    </div>
  );
}

export default App;
