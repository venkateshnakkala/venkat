var wrapper = document.getElementById("signature-pad"),
    clearButton = wrapper.querySelector("[data-action=clear]"),
    canvas = wrapper.querySelector("canvas"),
    signaturePad;


function resizeCanvas() {
    canvas.width = 250;
    canvas.height = 100;
    canvas.getContext("2d").scale(1, 1);
}

window.onresize = resizeCanvas;
resizeCanvas();

signaturePad = new SignaturePad(canvas);

clearButton.addEventListener("click", function (event) {
    signaturePad.clear();
});