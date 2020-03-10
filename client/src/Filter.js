import React from "react";
import debounce from "lodash/debounce";

function Filter({ onChangeCallback }) {
  const inputRef = React.useRef();

  const onChange = debounce(event => {
    onChangeCallback(inputRef.current.value);
  }, 300);

  return (
    <div className="d-flex w-100 align-items-center">
      <label className="text-nowrap pr-4">Player name:</label>{" "}
      <input
        className="form-control w-100"
        onChange={onChange}
        ref={inputRef}
      />
    </div>
  );
}

export default Filter;
