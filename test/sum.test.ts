import { sum } from "../src/sum";

describe("Sum", () => {
  it("adds two numbers together", () => {
    expect(sum(1, 2)).toBe(3);
  });
});
