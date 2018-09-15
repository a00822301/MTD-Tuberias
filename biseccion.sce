
//Método de biseccion para la ecuación Colebrook-White
//Una subfunción de tuberías.sce
//Jesús Emilio Jurado Martínez A01039987
//VER1.0

//A continuación se implementa el método de bisección
function biseccion(dRugosidad,dDiametro,dReynolds)
    
    //global x0
    //global x1
    //global xi
    //global y
    //El factor de fricción f solo puede tomar valores entre 0.008 y 0.1
    x0=0.008
    x1=0.1
    
    //Se define la ecuación Colebrook White igualada a 0
    function y=Colebrook(f,E,D,R)
        //la ecuación Colebrook-White igualada a cero
        y=-2*log10((E/(3.7*D))+(2.51/(R*sqrt(f))))-(1/sqrt(f));
    endfunction  

    //Se efectua el método
    iter=0;
    i = 0;
    while i<1 do
        xi=(x0+x1)/2 ;
        // Se evaluan los valores de entrada y el valor aproximado
        yx0=Colebrook(x0,dRugosidad,dDiametro,dReynolds);
        yx1=Colebrook(x1,dRugosidad,dDiametro,dReynolds);
        yxi=Colebrook(xi,dRugosidad,dDiametro,dReynolds);
             
       Signoxix0=yxi*yx0
        //Se obtiene el error iterativo aproximado
        ErrorAprox=abs((xi-x1)/xi)*100;
        //Si el error es menor al criterio de paro, se termina de iterar
        if ErrorAprox<0.0000000000001 then 
            i = 1;
        //Se revisa si la raiz está entre los valores
        elseif Signoxix0<0 then
            x1=xi;
        else
            x0=x1;
            x1=xi;
        end
        iter=iter+1
    end
    messagebox("la aproximación es "+string(xi))
    messagebox("Se realizaron "+string(iter)+" iteraciones!")
endfunction
