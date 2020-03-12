import { updateQueryParams } from "./url";

test("updateQueryParams adds a query parameter to the URL", () => {
  const url = "http://example.com";
  const params = { foo: "bar" };
  const updated_url = updateQueryParams(url, params);
  expect(updated_url).toMatch("foo=bar");
});

test("updateQueryParams removes a query parameter to the URL", () => {
  const url = "http://example.com?foo=bar";
  const params = { foo: null };
  const updated_url = updateQueryParams(url, params);
  expect(updated_url).not.toMatch("foo=bar");
});
