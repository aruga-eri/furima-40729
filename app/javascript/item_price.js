function setPriceCalculation() {
  const priceInput = document.getElementById("item-price");

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const addTaxDom = document.getElementById("add-tax-price");
      const ProfitDom = document.getElementById("profit");

      // 販売手数料の計算
      const taxAmount = Math.floor(inputValue * 0.1);
      addTaxDom.innerHTML = taxAmount;

      // 利益の計算
      ProfitDom.innerHTML = inputValue - taxAmount;
    });
  } else {
    console.error("Element with ID 'item-price' not found.");
  }
}

window.addEventListener('load', setPriceCalculation);
document.addEventListener('turbolinks:load', setPriceCalculation);
