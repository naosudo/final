function calculate() {
  const itemPrice = document.getElementById("item-price");
  if (!itemPrice) return; // 存在チェック

  itemPrice.addEventListener("keyup", (e) => {
    const price = Number(itemPrice.value);
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    if (300 <= price && price <= 9999999) {
      const fee = Math.floor(price / 10);
      addTaxPrice.innerHTML = fee;
      profit.innerHTML = price - fee;
    } else {
      addTaxPrice.innerHTML = 0;
      profit.innerHTML = 0;
    }
  });
}

document.addEventListener("turbo:load", calculate);