/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package cepp.genericos;

import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

/**
 *
 * @author Patricio
 */
public class PropiedadesINI
{
    /**
     * Lee un archivo ini tomando la ubicacion por una variable de entorno
     * y devuelve un valor el cual esta referenciado por la propiedad recibida.
     * Primero intenta leer de variables de entorno, si no existe, lee del archivo.
     *
     * @param xVariable
     * @return
     */
    public static String getPropiedad(String xVariable) throws Exception
    {
        // Primero intentar leer de variables de entorno
        String envValue = System.getenv(xVariable);
        if (envValue != null && !envValue.trim().isEmpty()) {
            return envValue;
        }
        
        // Si no existe en variables de entorno, leer del archivo
        Properties properties = new Properties();
        String retorno = null;
        FileInputStream streamArchivo = null;
        
        try
        {
            String iniFile = "CEPP.ini";

            if (iniFile == null || iniFile.trim().equals(""))
            {                
                throw new Exception("#alerta: Atenci&oacute;n, la variable de entorno no existe.");
            }

            streamArchivo = new FileInputStream(iniFile);
            properties.load(streamArchivo);
            retorno = properties.getProperty(xVariable);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
        finally
        {
            if (streamArchivo != null) {
                streamArchivo.close();
            }
        }
        return retorno;
    }
    
    /**
     * Obtiene la ruta en la que estan alojados los reportes
     * @return
     * @throws java.lang.Exception
     */
    public static String getDirReporteINI() throws Exception
    {
        try
        {
            return PropiedadesINI.getPropiedad("DIRREPS");
        }
        catch (Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
    }

    /**
     * Obtiene la ruta para los reportes generados
     * @return
     * @throws java.lang.Exception
     */
    public static String getDirReporteTempINI() throws Exception
    {
        try
        {
            return PropiedadesINI.getPropiedad("DIRREPSTEMP");
        }
        catch (Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
    }

    /**
     * Obtiene la cantidad de dias de tolerancia para eliminar los reportes generados
     * @return
     * @throws java.lang.Exception
     */
    public static int getDiasToleranciaReportes() throws Exception
    {
        try
        {
            return Integer.parseInt(PropiedadesINI.getPropiedad("DIASTOLERANCIAREPORTES"));
        }
        catch (Exception ex)
        {
            throw new Exception(ex.getMessage());
        }
    }
}
