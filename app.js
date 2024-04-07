
function generateQR(){
    event.preventDefault();
    var val = document.getElementById("product_id").value;
    console.log(val);
    let img = document.getElementById("qr-img");
    img.src = `https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${val}`;
}

async function connectToWallet(){
    event.preventDefault();
    if(typeof window.ethereum !== undefined){
    acc = await ethereum.request({method:"eth_requestAccounts"});
    }
    console.log(acc[0])
    alert("connected successfully");
  }