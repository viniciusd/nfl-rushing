import React from "react";

function DownloadButton({ downloadUrl }) {
  return (
    <div className="d-flex w-100 justify-content-center btn-toolbar">
      <form target="_blank">
        <button className="btn btn-outline-secondary" formaction={downloadUrl}>
          Download
        </button>
      </form>
    </div>
  );
}

export default DownloadButton;
