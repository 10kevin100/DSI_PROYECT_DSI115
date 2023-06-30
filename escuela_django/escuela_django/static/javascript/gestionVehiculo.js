(function(){
    let btnEliminar=document.querySelectorAll(".btnEliminacion");

    btnEliminar.forEach(btn=>{
    
        btn.addEventListener('click',(e)=>{
            let confirmacion=confirm("¿Seguro que desea eliminar este vehiculo?");
            if(!confirmacion){
                e.preventDefault();
            }
        });
    });

})();

