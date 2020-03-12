function updateQueryParams(requestUrl, updateParams) {
  let url = new URL(requestUrl);
  const params = new URLSearchParams(url.search);

  for (const key of Object.keys(updateParams)) {
    if (updateParams[key] === null) {
      params.delete(key);
    } else {
      params.set(key, updateParams[key]);
    }
  }
  url.search = params;
  return url.toString();
}

export { updateQueryParams };
