import React from "react";

function Pagination({
  disablePrevious,
  disableNext,
  previousPageCallback,
  nextPageCallback
}) {
  return (
    <div className="d-flex w-100 justify-content-center btn-toolbar">
      <div className="btn-group">
        <button
          className="btn btn-outline-primary"
          onClick={previousPageCallback}
          disabled={disablePrevious}
        >
          Previous
        </button>
        <button
          className="btn btn-outline-primary"
          onClick={nextPageCallback}
          disabled={disableNext}
        >
          Next
        </button>
      </div>
    </div>
  );
}

export default Pagination;
