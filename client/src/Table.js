import React from "react";
import "./table.css";

function Table({ sortBy, sorting, headers, records }) {
  const headerClass = header => {
    if (sorting.columns.includes(header)) {
      if (sorting.by === header) {
        if (sorting.order === "desc") {
          return "sorting-desc";
        } else if (sorting.order === "asc") {
          return "sorting-asc";
        }
      }
      return "sorting";
    } else {
      return "";
    }
  };
  const columnClass = header => {
    if (sorting.by === header) {
      return "sorting";
    } else {
      return "";
    }
  };

  return (
    <table className="table table-striped">
      <thead>
        <tr>
          {headers.map(header => (
            <th
              key={header}
              onClick={sortBy(header)}
              className={headerClass(header)}
            >
              {header}
            </th>
          ))}
        </tr>
      </thead>
      <tbody>
        {records.map(record => (
          <tr key={record["Player"]}>
            {headers.map(header => (
              <td key={header} className={columnClass(header)}>
                {record[header]}{" "}
              </td>
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
