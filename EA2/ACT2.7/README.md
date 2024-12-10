# AUY1105 - INFRAESTRUCTURA COMO CÓDIGO II

# PRUEBAS DE COMPATIBILIDAD Y DOCUMENTACIÓN DE RESULTADOS

## DESARROLLO DE ACTIVIDAD

```bash
go get github.com/gruntwork-io/terratest/modules/terraform
go get github.com/gruntwork-io/terratest/modules/test-structure
go get github.com/gruntwork-io/terratest/modules/aws
go get github.com/stretchr/testify/assert
```

```bash
go test -v vpc_module_test/vpc_test.go
```


## REFLEXIONES