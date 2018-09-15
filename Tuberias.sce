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


endfunction
