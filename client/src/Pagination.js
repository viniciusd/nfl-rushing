import React from "react";

function Pagination({ disablePrevious, previousPageCallback, nextPageCallback }) {
  return (
      <div className="d-flex w-100 justify-content-center btn-toolbar">
        <div className="btn-group">
          <button className="btn btn-outline-primary" onClick={previousPageCallback} disabled={disablePrevious}>Previous</button>
          <button className="btn btn-outline-primary" onClick={nextPageCallback}>Next</button>
        </div>
      </div>
  );
}

export default Pagination;
