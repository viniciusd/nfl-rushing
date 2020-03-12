import React from "react";
import axios from "axios";
import DownloadButton from "./DownloadButton";
import Filter from "./Filter";
import Pagination from "./Pagination";
import Table from "./Table";
import { updateQueryParams } from "./url";
import "bootstrap/dist/css/bootstrap.css";

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
    process.env.REACT_APP_API_URL
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
  const [loading, setLoading] = React.useState(true);

  const previousPage = () => {
    setRequestUrl(pagination.previous);
  };

  const nextPage = () => {
    setRequestUrl(pagination.next);
  };

  const setQueryParams = params => {
    const url = updateQueryParams(requestUrl, params);

    setRequestUrl(url);
  };

  const sortBy = header => () => {
    if (sorting.columns.includes(header)) {
      let order;
      if (sorting.order === null || sorting.by !== header) {
        order = "desc";
      } else if (sorting.order === "desc") {
        order = "asc";
      } else if (sorting.order === "asc") {
        order = null;
      }

      const by = order !== null ? header : null;
      setSorting({
        ...sorting,
        by: by,
        order: order
      });
      setQueryParams({
        sort: by || null,
        order: order || null
      });
    }
  };

  const setFilter = filter => {
    setQueryParams({ page_number: null, filter: filter || null });
  };

  const downloadUrl = url => updateQueryParams(url, { csv: true });

  React.useEffect(() => {
    async function fetchData() {
      try {
        setLoading(true);
        const records = (await axios.get(requestUrl)).data;
        setLoading(false);
        setRecords(records.data);
        setPagination({
          previous:
            records["_links"]["prev"] && records["_links"]["prev"]["href"],
          next: records["_links"]["next"] && records["_links"]["next"]["href"]
        });
      } catch (err) {
        setError(err.message);
      }
    }
    fetchData();
  }, [requestUrl]);

  return (
    <div className="App">
      <div className="p-4">
        <Filter onChangeCallback={setFilter} />
      </div>
      <DownloadButton downloadUrl={downloadUrl(requestUrl)} />
      {error ? (
        <h1 className="d-flex w-100 justify-content-center">
          <span className="badge badge-warning">{error}</span>
        </h1>
      ) : loading ? (
        <div className="d-flex justify-content-center m-4">
          <div className="spinner-border" role="status">
            <span className="sr-only">Loading...</span>
          </div>
        </div>
      ) : (
        <Table
          sortBy={sortBy}
          sorting={sorting}
          headers={headers}
          records={records}
        />
      )}
      <Pagination
        disablePrevious={!pagination.previous}
        disableNext={!pagination.next}
        previousPageCallback={previousPage}
        nextPageCallback={nextPage}
      />
    </div>
  );
}

export default App;
