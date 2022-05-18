// グローバル変数を定義（要素取得用）
var figureNumber, productName, material, surfaceTreatment;
var length, width, height, outerDia, long, insideDia;
var weightResult, weightScale, weightPrice, weightPriceSelect;
var areaResult, areaScale, areaPrice, areaPriceSelect;
var sizeResult, sizeScale, sizePrice, sizePriceSelect;
var priceResult, drawing_quantity, drawing_notes;

const calPrice = (priceScaleHash, calWeight, calArea, calSize) => {
  // 単価表のインスタンス変数から選択された単価表のみを取り出す
  let inputSurfaceTreatment = surfaceTreatment.value;
  let priceScale = priceScaleHash.find((v) => v.title === inputSurfaceTreatment);
  // 重量計算：重量によってカラムを選択
  if ( calWeight < 3 ) {
    weightScale.value = priceScale.scale_w_0_3;
    // 十の位で切り上げ
    let calWeightPrice = Math.ceil( calWeight * weightScale.value / 10 ) * 10;
    // 最低単価を下回る場合は最低単価を採用
    if (calWeightPrice < priceScale.min_unit_price) {
      weightPrice.value = priceScale.min_unit_price;
    } else {
      weightPrice.value = calWeightPrice;
    };
  } else if ( calWeight >= 3 && calWeight < 6 ) {
    weightScale.value = priceScale.scale_w_3_6;
    weightPrice.value = Math.ceil( calWeight * weightScale.value / 10 ) * 10;
  } else if ( calWeight >= 6 && calWeight < 11 ) {
    weightScale.value = priceScale.scale_w_6_11;
    weightPrice.value = Math.ceil( calWeight * weightScale.value / 10 ) * 10;
  } else if ( calWeight >= 11 && calWeight < 15 ) {
    weightScale.value = priceScale.scale_w_11_15;
    weightPrice.value = Math.ceil( calWeight * weightScale.value / 10 ) * 10;
  } else if ( calWeight >= 15 && calWeight < 22 ) {
    weightScale.value = priceScale.scale_w_15_22;
    weightPrice.value = Math.ceil( calWeight * weightScale.value / 10 ) * 10;
  } else if ( calWeight >= 22 && calWeight < 30 ) {
    weightScale.value = priceScale.scale_w_22_30;
    weightPrice.value = Math.ceil( calWeight * weightScale.value / 10 ) * 10;
  } else if ( calWeight >= 30 && calWeight < 50 ) {
    weightScale.value = priceScale.scale_w_30_50;
    weightPrice.value = Math.ceil( calWeight * weightScale.value / 10 ) * 10;
  } else if ( calWeight >= 50 && calWeight < 80 ) {
    weightScale.value = priceScale.scale_w_50_80;
    weightPrice.value = Math.ceil( calWeight * weightScale.value / 10 ) * 10;
  } else if ( calWeight >= 80 && calWeight < 150 ) {
    weightScale.value = priceScale.scale_w_80_150;
    weightPrice.value = Math.ceil( calWeight * weightScale.value / 10 ) * 10;
  } else if ( calWeight >= 150 && calWeight < 180 ) {
    weightScale.value = priceScale.scale_w_150_180;
    weightPrice.value = Math.ceil( calWeight * weightScale.value / 10 ) * 10;
  } else if ( calWeight >= 180 ) {
    weightScale.value = priceScale.scale_w_180over;
    weightPrice.value = Math.ceil( calWeight * weightScale.value / 10 ) * 10;
  };
  // 面積計算：面積によってカラムを選択
  if ( calArea < 3 ) {
    areaScale.value = priceScale.scale_w_0_3;
    let calAreaPrice = Math.ceil( calArea * areaScale.value / 10 ) * 10;
    if (calAreaPrice < priceScale.min_unit_price) {
      areaPrice.value = priceScale.min_unit_price;
    } else {
      areaPrice.value = calAreaPrice;
    };
  } else if ( calArea >= 3 && calArea < 6 ) {
    areaScale.value = priceScale.scale_a_3_6;
    areaPrice.value = Math.ceil( calArea * areaScale.value / 10 ) * 10;
  } else if ( calArea >= 6 && calArea < 11 ) {
    areaScale.value = priceScale.scale_a_6_11;
    areaPrice.value = Math.ceil( calArea * areaScale.value / 10 ) * 10;
  } else if ( calArea >= 11 && calArea < 15 ) {
    areaScale.value = priceScale.scale_a_11_15;
    areaPrice.value = Math.ceil( calArea * areaScale.value / 10 ) * 10;
  } else if ( calArea >= 15 && calArea < 22 ) {
    areaScale.value = priceScale.scale_a_15_22;
    areaPrice.value = Math.ceil( calArea * areaScale.value / 10 ) * 10;
  } else if ( calArea >= 22 && calArea < 30 ) {
    areaScale.value = priceScale.scale_a_22_30;
    areaPrice.value = Math.ceil( calArea * areaScale.value / 10 ) * 10;
  } else if ( calArea >= 30 && calArea < 50 ) {
    areaScale.value = priceScale.scale_a_30_50;
    areaPrice.value = Math.ceil( calArea * areaScale.value / 10 ) * 10;
  } else if ( calArea >= 50 && calArea < 80 ) {
    areaScale.value = priceScale.scale_a_50_80;
    areaPrice.value = Math.ceil( calArea * areaScale.value / 10 ) * 10;
  } else if ( calArea >= 80 && calArea < 150 ) {
    areaScale.value = priceScale.scale_a_80_150;
    areaPrice.value = Math.ceil( calArea * areaScale.value / 10 ) * 10;
  } else if ( calArea >= 150 && calArea < 180 ) {
    areaScale.value = priceScale.scale_a_150_180;
    areaPrice.value = Math.ceil( calArea * areaScale.value / 10 ) * 10;
  } else if ( calArea >= 180 ) {
    areaScale.value = priceScale.scale_a_180over;
    areaPrice.value = Math.ceil( calArea * areaScale.value / 10 ) * 10;
  };
  // 外径計算：外径の合計によってカラムを選択
  if ( calSize < 300 ) {
    sizeScale.value = priceScale.scale_o_0_300;
    let calSizePrice = Math.ceil( calSize / sizeScale.value / 10 ) * 10;
    if (calSizePrice < priceScale.min_unit_price) {
      sizePrice.value = priceScale.min_unit_price;
    } else {
      sizePrice.value = calSizePrice;
    };
  } else if ( calSize >= 300 && calSize < 500 ) {
    sizeScale.value = priceScale.scale_o_300_500;
    sizePrice.value = Math.ceil( calSize / sizeScale.value / 10 ) * 10;
  } else if ( calSize > 500 ) {
    sizeScale.value = priceScale.scale_o_500over;
    sizePrice.value = Math.ceil( calSize / sizeScale.value / 10 ) * 10;
  };
};


const buildHTML = (XHR) => {
  const item = XHR.response.post;
  const html = `
  <div class="drawings-list">
      
  <div class="left-area">

    <div class="top-area">
    
      <div class="number-area">
        図番:${ item.figure_number }
      </div>
      <div class="name-area">
        品名:${ item.product_name }
      </div>
    </div>

    <div class="bottom-area">

      <div class="treatment-area">
        ${ item.surface_treatment }
      </div>
      <div class="material-area">
        ${ item.material }
      </div>
      <div class="size-area">
        ${ item.size }
      </div>

    </div>

  </div>

  <div class="quantity-area">
    ${ item.quantity }個
  </div>

  <div class="price-area">
    ${ item.price }円
  </div>

  <div class="totalprice-area">
    ${ item.price * item.quantity }円
  </div>

  <div class="notes-area">
    ${ item.notes }
   </div>

</div>
    `;
  return html;
};


window.addEventListener('load',() => {

  // グローバル変数に要素を取得
  figureNumber = document.getElementById("figure_number");
  productName = document.getElementById("product_name");
  material = document.getElementById("material");
  surfaceTreatment = document.getElementById("drawing_surface_treatment");
  length = document.getElementById("length");
  width = document.getElementById("width");
  height = document.getElementById("height");
  outerDia = document.getElementById("outer_dia");
  long = document.getElementById("long");
  insideDia = document.getElementById("inside_dia");
  weightResult = document.getElementById("weight_result");
  weightScale = document.getElementById("weight_scale");
  weightPrice = document.getElementById("weight_price");
  weightPriceSelect = document.getElementById("weight_price_select");
  areaResult = document.getElementById("area_result");
  areaScale = document.getElementById("area_scale");
  areaPrice = document.getElementById("area_price");
  areaPriceSelect = document.getElementById("area_price_select");
  sizeResult = document.getElementById("size_result");
  sizeScale = document.getElementById("size_scale");
  sizePrice = document.getElementById("size_price");
  sizePriceSelect = document.getElementById("size_price_select");
  priceResult = document.getElementById("price_result");
  drawingQuantity = document.getElementById("drawing_quantity");
  drawingNotes = document.getElementById("drawing_notes");

  // 重量、面積の計算
  // 計算用の変数の定義
  let inputLength = 0;
  let inputWidth = 0;
  let inputHeight = 0;
  let inputOuterDia = 0;
  let inputLong = 0;
  let inputInsideDia = 0;
  let calWeight = 0;
  let calArea = 0;
  let calSize = 0;

  // 単価表のインスタンス変数を取得
  const priceScales = document.getElementById("price_scales");
  const priceScaleHash = JSON.parse(priceScales.getAttribute("data-priceScales-status"));

  // 以下直方体の場合の計算
  length.addEventListener("input",() => {
    inputLength = length.value;
    calWeight = inputLength * inputWidth * inputHeight * 7.86 / 1000000;
    weightResult.value = calWeight;
    calArea = ( inputLength * inputWidth + inputWidth * inputHeight + inputHeight * inputLength) * 2 / 10000;
    areaResult.value = calArea;
    calSize = Number(inputLength) + Number(inputWidth) + Number(inputHeight);
    sizeResult.value = `${inputLength}*${inputWidth}*${inputHeight}`;
    calPrice(priceScaleHash, calWeight, calArea, calSize);
  });

  width.addEventListener("input",() => {
    inputWidth = width.value;
    calWeight = inputLength * inputWidth * inputHeight * 7.86 / 1000000;
    weightResult.value = calWeight;
    calArea = ( inputLength * inputWidth + inputWidth * inputHeight + inputHeight * inputLength) * 2 / 10000;
    areaResult.value = calArea;
    calSize = Number(inputLength) + Number(inputWidth) + Number(inputHeight);
    sizeResult.value = `${inputLength}*${inputWidth}*${inputHeight}`;
    calPrice(priceScaleHash, calWeight, calArea, calSize);
  });

  height.addEventListener("input",() => {
    inputHeight = height.value;
    calWeight = inputLength * inputWidth * inputHeight * 7.86 / 1000000;
    weightResult.value = calWeight;
    calArea = ( inputLength * inputWidth + inputWidth * inputHeight + inputHeight * inputLength) * 2 / 10000;
    areaResult.value = calArea;
    calSize = Number(inputLength) + Number(inputWidth) + Number(inputHeight);
    sizeResult.value = `${inputLength}*${inputWidth}*${inputHeight}`;
    calPrice(priceScaleHash, calWeight, calArea, calSize);
  });

  // 以下円柱または筒の場合の計算
  outerDia.addEventListener("input",() => {
    inputOuterDia = outerDia.value;
    calWeight = inputOuterDia * inputOuterDia * inputLong * 3.14 * 7.86 / 4000000
                    - inputInsideDia * inputInsideDia * inputLong * 3.14 * 7.86 / 4000000;
    weightResult.value = calWeight;
    calArea = ( inputOuterDia * inputOuterDia * 3.14 / 2 + inputOuterDia * inputLong * 3.14
                  - inputInsideDia * inputInsideDia * 3.14 / 2 + inputInsideDia * inputLong * 3.14 ) / 10000;
    areaResult.value = calArea;
    calSize = Number(inputOuterDia) * 2 + Number(inputLong);
    // 内径の有無で表示を変更
    if ( inputInsideDia == 0 ) {
      sizeResult.value = `Φ${inputOuterDia}*${inputLong}`;
    } else {
      sizeResult.value = `Φ${inputOuterDia}-Φ${inputInsideDia}*${inputLong}`;
    };
    calPrice(priceScaleHash, calWeight, calArea, calSize);
  });

  long.addEventListener("input",() => {
    inputLong = long.value;
    calWeight = inputOuterDia * inputOuterDia * inputLong * 3.14 * 7.86 / 4000000
                    - inputInsideDia * inputInsideDia * inputLong * 3.14 * 7.86 / 4000000;
    weightResult.value = calWeight;
    calArea = ( inputOuterDia * inputOuterDia * 3.14 / 2 + inputOuterDia * inputLong * 3.14
                  - inputInsideDia * inputInsideDia * 3.14 / 2 + inputInsideDia * inputLong * 3.14 ) / 10000;
    areaResult.value = calArea;
    calSize = Number(inputOuterDia) * 2 + Number(inputLong);
    if ( inputInsideDia == 0 ) {
      sizeResult.value = `Φ${inputOuterDia}*${inputLong}`;
    } else {
      sizeResult.value = `Φ${inputOuterDia}-Φ${inputInsideDia}*${inputLong}`;
    };
    calPrice(priceScaleHash, calWeight, calArea, calSize);
  });

  insideDia.addEventListener("input",() => {
    inputInsideDia = insideDia.value;
    calWeight = inputOuterDia * inputOuterDia * inputLong * 3.14 * 7.86 / 4000000
                    - inputInsideDia * inputInsideDia * inputLong * 3.14 * 7.86 / 4000000;
    weightResult.value = calWeight;
    calArea = ( inputOuterDia * inputOuterDia * 3.14 / 2 + inputOuterDia * inputLong * 3.14
                  - inputInsideDia * inputInsideDia * 3.14 / 2 + inputInsideDia * inputLong * 3.14 ) / 10000;
    areaResult.value = calArea;
    calSize = Number(inputOuterDia) * 2 + Number(inputLong);
    if ( inputInsideDia == 0 ) {
      sizeResult.value = `Φ${inputOuterDia}*${inputLong}`;
    } else {
      sizeResult.value = `Φ${inputOuterDia}-Φ${inputInsideDia}*${inputLong}`;
    };
    calPrice(priceScaleHash, calWeight, calArea, calSize);
  });

  weightResult.addEventListener("input",() => {
    let inputWeightResult = weightResult.value;
    calPrice(priceScaleHash, inputWeightResult, calArea, calSize);
  });

  weightScale.addEventListener("input",() => {
    let inputSurfaceTreatment = surfaceTreatment.value;
    let priceScale = priceScaleHash.find((v) => v.title === inputSurfaceTreatment);
    let calWeightPrice = Math.ceil(weightResult.value * weightScale.value / 10) * 10;
    if (calWeightPrice < priceScale.min_unit_price) {
      weightPrice.value = priceScale.min_unit_price;
    } else {
      weightPrice.value = calWeightPrice;
    };
  });

  areaResult.addEventListener("input",() => {
    let inputAreaResult = areaResult.value;
    calPrice(priceScaleHash, inputAreaResult, calArea, calSize);
  });

  areaScale.addEventListener("input",() => {
    let inputSurfaceTreatment = surfaceTreatment.value;
    let priceScale = priceScaleHash.find((v) => v.title === inputSurfaceTreatment);
    let calAreaPrice = Math.ceil(areaResult.value * areaScale.value / 10) * 10;
    if (calAreaPrice < priceScale.min_unit_price) {
      areaPrice.value = priceScale.min_unit_price;
    } else {
      areaPrice.value = calAreaPrice;
    };
  });

  sizeScale.addEventListener("input",() => {
    let inputSurfaceTreatment = surfaceTreatment.value;
    let priceScale = priceScaleHash.find((v) => v.title === inputSurfaceTreatment);
    let calSizePrice = Math.ceil(calSize / sizeScale.value / 10) * 10;
    if (calSizePrice < priceScale.min_unit_price) {
      sizePrice.value = priceScale.min_unit_price;
    } else {
      sizePrice.value = calSizePrice;
    };
  });

  weightPriceSelect.addEventListener("click",() => {
    priceResult.value = weightPrice.value;
  });

  areaPriceSelect.addEventListener("click",() => {
    priceResult.value = areaPrice.value;
  });

  sizePriceSelect.addEventListener("click", () => {
    priceResult.value = sizePrice.value;
  });


  // 以下Ajax
  const submit = document.getElementById("submit");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const form = document.getElementById("form");
    const formData = new FormData(form);
    const XHR = new XMLHttpRequest();
    const quotationIdEle = document.getElementById("quotation_id")
    const quotationId = quotationIdEle.value
    // const pathName = location.pathname;
    XHR.open("POST", `/quotations/${quotationId}/drawings`, true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      };
      const list = document.getElementById("list");
      list.insertAdjacentHTML("beforebegin", buildHTML(XHR));
      figureNumber.value = "";
      productName.value = "";
      material.value = "";
      length.value = "";
      width.value = "";
      height.value = "";
      outerDia.value = "";
      long.value = "";
      insideDia.value = "";
      weightResult.value = "";
      weightScale.value = "";
      weightPrice.value = "";
      areaResult.value = "";
      areaScale.value = "";
      areaPrice.value = "";
      sizeResult.value = "";
      sizeScale.value = "";
      sizePrice.value = "";
      priceResult.value = "";
      drawingQuantity.value = "";
      drawingNotes.value = "";
    };
  });


});