import React from "react";
import axios from "axios";
import Filter from "./Filter";
import Table from "./Table";
import "bootstrap/dist/css/bootstrap.css";

async function fetchRecords() {
  const resp = await axios.get("http://localhost:8080/rushing.json");
  return resp.data.slice(0, 10);
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
  const [error, setError] = React.useState("");

  async function filter(name) {
    setRecords(await applyFilter(name));
  }

  React.useEffect(() => {
    async function fetchData() {
      try {
        const records = await fetchRecords();
        setRecords(records);
      } catch (err) {
        setError(err.message);
      }
    }
    fetchData();
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        {error && <span>{error}</span>}
        <div className="p-4">
          <Filter onChangeCallback={filter} />
        </div>
        <Table headers={headers} records={records} />
      </header>
    </div>
  );
}

async function applyFilter(name) {
  const records = await fetchRecords();
  return records.filter(record => record["Player"].includes(name));
}

export default App;
