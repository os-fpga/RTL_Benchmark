PACKAGE EdgeDetection_pkg IS
    FUNCTION DetermineKernel(EdgeDetectionType : STRING) RETURN INTEGER;
END PACKAGE;

PACKAGE BODY EdgeDetection_pkg IS
    FUNCTION DetermineKernel(EdgeDetectionType : STRING) RETURN INTEGER IS
        VARIABLE edgeSize                          : NATURAL := 0;
    BEGIN
        IF EdgeDetectionType = "3" THEN
            edgeSize := 1;
        ELSE
            edgeSize := 2;
        END IF;
        RETURN edgeSize;
    END FUNCTION;
END PACKAGE BODY;