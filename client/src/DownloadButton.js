import React from "react";

function DownloadButton({ downloadUrl }) {
  return (
    <div className="d-flex w-100 justify-content-center btn-toolbar">
      <a href={downloadUrl} target="_top">
        <button className="btn btn-outline-secondary">Download</button>
      </a>
    </div>
  );
}

export default DownloadButton;
