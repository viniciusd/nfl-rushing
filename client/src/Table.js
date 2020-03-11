import React from "react";

function Table({ headers, records }) {
  return (
    <table className="table">
      <thead>
        <tr>
          {headers.map(header => (
            <th key={header}>{header}</th>
          ))}
        </tr>
      </thead>
      <tbody>
        {records.map(record => (
          <tr key={record["Player"]}>
            {headers.map(header => (
              <td key={header}>{record[header]}</td>
            ))}
          </tr>
        ))}
      </tbody>
      <tfoot>
        <tr>
          {headers.map(header => (
            <th key={header}>{header}</th>
          ))}
        </tr>
      </tfoot>
    </table>
  );
}

export default Table;
