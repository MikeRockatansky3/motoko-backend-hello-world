import Result "mo:base/Result";

module Types {
    //type: Definir la estructura de un tipo de dato
    public type User = {
        id: Principal;
        firstName: Text;
        lastName: Text;
    };


    //Type personalizado para el result. Dos Result, el primero es el módulo Result, y el 2o un type dentro del módulo
    //El tipo espera dos parámetros, uno para cuando todo está bien y otro cuando algo sale mal.
    type GetUsersResult = Result.Result<[Types.User], Text>;
};