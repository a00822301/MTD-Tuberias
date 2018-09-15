////////////////////////////////////////////////////
// Tuberias.sce
// Módulo con funciones que calculan ciertos valores
// importantes en el análisis de fluje de tuberías mediante
// la utilización de métodos numéricos
// 
// Carla Judith López Zurita    A00822301
// Adrián Garza Garza           A00822122
//
// 11/09/2018  versión 1.0 
////////////////////////////////////////////////////

////////////////////////////////////////////////////
// Tuberias
// Función principal
// Parámetros:
// Retorno:
////////////////////////////////////////////////////
function Tuberias()

// Etiquetas de los datos. Vector de 1 columna y 5 renglones
vLabels = [ "Densidad del fluido(kg/m^3)"; "Viscosidad dinámica (kg/m*s)"; "Diámetro interno de la tubería (mm)";"Rugosidad de la tubería (mm)";"Flujo volumétrico (m^3/s)"]
// Valores Default. Vector de 1 columna y 5 renglones
vValoresDefault = ["";"";"";"";""]

// Se manda a llamar la ventana modal con los parámetros: Titulo de la Ventana, Etiquetas de datos y valores default
vResultados = x_mdialog("Introduzca los datos:",vLabels,vValoresDefault)

// leemos uno a uno los valores
dDensidad = evstr(vResultados(1))
dViscosidad = evstr(vResultados(2))
dDiametro = evstr(vResultados(3))/1000
dRugosidad = evstr(vResultados(4))/1000
dFlujo = evstr(vResultados(5))

dVelocidad = dFlujo/(dDiametro/2)^2*%pi

// Con los datos obtenidos se calcula el número de Reynolds
dReynolds = dDensidad*dVelocidad*dDiametro/dViscosidad

// régimen de flujo
if ((dReynolds < 2400) & (dReynolds>0)) then
    sRegimen = "laminar" 
    messagebox("El flujo es "+sRegimen)
    dFriccion = 64/dReynolds
elseif ((dReynolds >=2400) & (dReynolds <= 4000)) then
    sRegimen = "de transición" 
    messagebox("El flujo es "+sRegimen)
    // dFriccion = function(FriccionTransicion)
    // hacer estas funciones
    
elseif (dReynolds > 4000) then
    sRegimen = "turbulento" 
    messagebox("El flujo es "+sRegimen)
    // dFriccion = function(FriccionTurbulento)
    // mandamos a llamar estas funciones
else
    sRegimen = "Error"
    messagebox("No se puede calcular, inserte los datos correctamente")
    abort
end

// Con los datos obtenidos se calcula el factor de fricción
// Necesitamos hacer las funciones para calcular el factor de fricción de flujo de Transición y Turbulento

// Se despliega mensaje final


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
biseccion(dRugosidad,dDiametro,dReynolds)
endfunction
