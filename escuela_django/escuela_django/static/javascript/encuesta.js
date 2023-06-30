document.addEventListener("DOMContentLoaded", function() {
  const textarea = document.getElementById("miTextarea");
  const maxLength = 255;
  const mensajeError = document.getElementById("mensajeError");

  textarea.addEventListener("input", function() {
    const text = textarea.value;
    const remainingChars = maxLength - text.length;

    if (remainingChars < 0) {
      textarea.value = text.slice(0, maxLength);
      mensajeError.innerText = "Has alcanzado el máximo de 255 caracteres.";
    } else {
      mensajeError.innerText = "";
    }
  });
});





