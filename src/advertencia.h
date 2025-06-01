#include <windows.h>

int main() {
    const char* mensaje = R"(

   /!\ /!\ /!\ /!\ /!\ /!\ /!\ /!\
  /!\                             
 /!\   ⚠️ ADVERTENCIA ⚠️   
/!\                            
/!\  Estas a punto de ejecutar un Malware  
/!\  potencialmente peligroso, no es broma.  
/!\                             
/!\  ▶ Es un GDI troyan, venga ◀ 
/!\                             
/!\  Si no sabes que estas a punto de ejecutar, ni lo toques   
/!\  No se realizará ningún daño.  Con la version Safety ;)
 \!\_____________________________/

¿Deseas continuar?
)";

    int respuesta = MessageBoxA(
        NULL,
        mensaje,
        "VoidExcept-512 - Advertencia",
        MB_YESNO | MB_ICONWARNING | MB_SYSTEMMODAL
    );

    if (respuesta == IDYES) {
        MessageBoxA(NULL, "Adios, buena suerte.\n;(", "Creado por AitorFirmware X Aitor (Apodame Null22)", MB_OK | MB_ICONINFORMATION);
    }
    else {
        MessageBoxA(NULL, "Operacion cancelada por el usuario, te has salvado solo por este codigo, el original no tiene este msgbox ;).", "", MB_OK | MB_ICONINFORMATION);
    }

    return 0;
}