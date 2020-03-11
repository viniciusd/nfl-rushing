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
  const [previous, setPrevious] = React.useState("");
  const [current, setCurrent] = React.useState(
    "http://localhost:4000/api/players"
  );
  const [next, setNext] = React.useState("");
  const [sorting, setSorting] = React.useState({
    columns: ["Yds", "Lng", "TD"],
    order: "desc",
    by: null
  });
  const [error, setError] = React.useState("");

  async function filter(name) {
    setRecords(await applyFilter(name));
  }

  function previousPage() {
    setCurrent(previous);
  }

  function nextPage() {
    setCurrent(next);
  }

  function sortBy(header) {
    return () => {
      if (sorting.columns.includes(header)) {
        setSorting({
          ...sorting,
          by: header,
          order: sorting.order === "desc" ? "asc" : "desc"
        });
      }
    };
  }

  React.useEffect(() => {
    async function fetchData() {
      try {
        const records = await fetchRecords(current);
        const currentPage = records["_links"]["self"]["href"];
        if (currentPage !== current) {
          setRecords(records.data);
          setPrevious(
            records["_links"]["prev"] && records["_links"]["prev"]["href"]
          );
          setNext(records["_links"]["next"]["href"]);
          setCurrent(currentPage);
        }
      } catch (err) {
        setError(err.message);
      }
    }
    fetchData();
  }, [current]);

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
          disablePrevious={!previous}
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
