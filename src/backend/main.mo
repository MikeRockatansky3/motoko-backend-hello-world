import Principal "mo:base/Principal";
import Debug "mo:base/Debug";
import Result "mo:base/Result";

actor {
    stable var name: Text = "";

    //type: Definir la estructura de un tipo de dato
    type User = (Text, Nat);

    //Arreglo de usuarios del tipo User

    var users: [User] = [
        ("Miguel", 17),
        ("Adrián", 36)
    ];

    //Registrar nombre
    public shared func setName(newName: Text): async () {
        name := newName;
    };

    //Obtener nombre
    public query func getName () : async (Text) {
        return name;
    };

    //Verificar autenticaciones
    public shared query (message) func whoAmI(): async Principal {
        return message.caller;
    };

    //Type personalizado para el result. Dos Result, el primero es el módulo Result, y el 2o un type dentro del módulo
    //El tipo espera dos parámetros, uno para cuando todo está bien y otro cuando algo sale mal.
    type GetUsersResult = Result.Result<[User], Text>;

    //Mi identificador de la página:
    //er2hr-ypru2-orkmg-h2u3q-x3ihs-3iqa6-7wuu7-7ngme-2l2ij-2ogts-wae

    //Validación para obtener sólo usuarios autenticados
    public shared query ({caller}) func getUsers(): async GetUsersResult {
        Debug.print("Caller: " # Principal.toText(caller));

        if(Principal.isAnonymous(caller)) {
            //Usar Debug.print SÓLO en proceso de desarrollo, quitar al momento de mandar a producción
            Debug.print("Usuario anónimo");
            //return []; //Si el usuario no está utenticado regresa un array vacío
            return #err("Debes estar autenticado para ver los usuarios"); //Regresar un mensaje en vez de un array vacío
            }; 
        
        //Si está utenticado, regresar la vista real de usuarios
        Debug.print("Usuario autenticado");
        return #ok(users);
    }
}