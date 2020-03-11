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
    "http://localhost:4000/api/players"
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
  const [error, setError] = React.useState("");

  async function filter(name) {
    setRecords(await applyFilter(name));
  }

  function previousPage() {
    setRequestUrl(pagination.previous);
  }

  function nextPage() {
    setRequestUrl(pagination.next);
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
    let url = new URL(requestUrl);
    const params = new URLSearchParams(url.search);

    if (sorting.order !== null && sorting.by !== null) {
      params.set("sort", sorting.by);
      params.set("order", sorting.order);
    } else {
      params.delete("sort");
      params.delete("order");
    }

    url.search = params;
    url = url.toString();

    if (url !== requestUrl) {
      setRequestUrl(url);
    }
  }, [requestUrl, sorting]);

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
          <Filter onChangeCallback={filter} />
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

async function applyFilter(name) {
  const records = (await fetchRecords()).data;
  return records.filter(record => record["Player"].includes(name));
}

export default App;
