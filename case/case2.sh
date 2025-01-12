    #!bin/bash

    echo -n "Enter the name of a car brand: "
    read car

    case $car in

        "Porsche" | "Audi" | "BMW" | "Mersedes" )
            echo "The cars are made in Germany."
            ;;
        "Mazda" | "Suzuki" | "Toyota" | "Honda")
            echo -n "${car} factory in Japan"
            ;;
        "Tesla" )
            echo -n "${car} are is made in USA"
            ;;
        * )
            echo -n "${car} is unknown brand or made elsewhere  "
            ;;
    esac