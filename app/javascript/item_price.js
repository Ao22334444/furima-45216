const setupPriceCalc = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  const taxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  const render = () => {
    const v = Number(priceInput.value);

    if (!Number.isFinite(v) || priceInput.value === "") {
      taxDom.textContent = "";
      profitDom.textContent = "";
      return;
    }

    const fee = Math.floor(v * 0.1);
    const profit = Math.floor(v - fee);

    taxDom.textContent = fee;
    profitDom.textContent = profit;
  };

  render();

  priceInput.addEventListener("input", render);
};

window.addEventListener("turbo:load", setupPriceCalc);
window.addEventListener("turbo:render", setupPriceCalc);