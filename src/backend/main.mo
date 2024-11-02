//Importar módulos base
import Principal "mo:base/Principal";
//import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
//import HashMap "mo:base/HashMap";
//Importar módulos de Mops
import Map "mo:map/Map"; //Librería map: Hacer hash map estables
import { thash } "mo:map/Map";
//Importar el módulo types (Del archivo types.mo)
import Types "types";

actor {
    stable var name: Text = "";

    /*Hashmap de usuarios
    //El primer HashMap es un módulo, el segundo es un type HashMap
    //Los parámetros <Text, User> son igual a <Identificador del elemento, Tipo de dato del elemento>
    var usersMap = HashMap.HashMap<Text, Types.User>(5, Text.equal, Text.hash);
    */
    var users = Map.new<Text, Types.User>();

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

    public shared func addUser(data: Types.User): () {
        Map.set(users, thash, Principal.toText(data.id), data);
    };

    public shared func deleteUser(id: Principal): () {
        Map.delete(users, thash, Principal.toText(id));
    };





    //Mi identificador de la página:
    //er2hr-ypru2-orkmg-h2u3q-x3ihs-3iqa6-7wuu7-7ngme-2l2ij-2ogts-wae

/*
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
*/
}