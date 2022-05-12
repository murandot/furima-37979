window.addEventListener('load', function()  {

  const itemPrice = document.getElementById("item-price");

  itemPrice.addEventListener('input', function() {
    const inputValue = itemPrice.value;
    
    const addTaxPrice = document.getElementById("add-tax-price");
    const addTaxPriceValue = Math.round(inputValue * 0.1);
    addTaxPrice.innerHTML = addTaxPriceValue

    const profit = document.getElementById("profit");
    profit.innerHTML = Math.round(inputValue - addTaxPriceValue);

  });
});