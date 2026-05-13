Sub GeneratePPTForEA2_ACT27_28()
    ' Crear una nueva presentación de PowerPoint
    Dim pptApp As Object
    Dim pptPres As Object
    Dim slide As Object
    Dim titleShape As Object
    Dim contentShape As Object
    Dim slideIndex As Integer
    
    ' Inicializar PowerPoint
    On Error Resume Next
    Set pptApp = GetObject(, "PowerPoint.Application")
    If pptApp Is Nothing Then
        Set pptApp = CreateObject("PowerPoint.Application")
    End If
    On Error GoTo 0
    
    pptApp.Visible = True
    
    ' Crear nueva presentación
    Set pptPres = pptApp.Presentations.Add
    
    ' Slide 1: Título
    slideIndex = 1
    Set slide = pptPres.Slides.Add(slideIndex, 1) ' ppLayoutTitle
    Set titleShape = slide.Shapes(1)
    titleShape.TextFrame.TextRange.Text = "AUY1105 - Infraestructura como Código II"
    Set contentShape = slide.Shapes(2)
    contentShape.TextFrame.TextRange.Text = "Presentación para EA2 ACT2.7 y ACT2.8"
    
    ' Slide 2: ACT2.7 - Título
    slideIndex = slideIndex + 1
    Set slide = pptPres.Slides.Add(slideIndex, 1)
    Set titleShape = slide.Shapes(1)
    titleShape.TextFrame.TextRange.Text = "ACT2.7: Pruebas de Compatibilidad y Documentación de Resultados"
    Set contentShape = slide.Shapes(2)
    contentShape.TextFrame.TextRange.Text = "Proceso de validación: Uso de Terratest para probar el módulo VPC, documentar resultados de pruebas exitosas y fallidas, y validar compatibilidad forzando errores."
    
    ' Slide 3: ACT2.7 - Proceso de Documentación y Validación
    slideIndex = slideIndex + 1
    Set slide = pptPres.Slides.Add(slideIndex, 2) ' ppLayoutText
    Set titleShape = slide.Shapes(1)
    titleShape.TextFrame.TextRange.Text = "Proceso de Documentación y Validación en ACT2.7"
    Set contentShape = slide.Shapes(2)
    contentShape.TextFrame.TextRange.Text = _
        "- Validación con Terratest: Ejecutar pruebas automatizadas en el módulo VPC para verificar funcionalidad." & vbCrLf & _
        "- Documentación de Resultados: Registrar salidas de pruebas exitosas, incluyendo configuraciones válidas." & vbCrLf & _
        "- Pruebas de Error: Modificar variables (ej. región) para forzar fallos y documentar comportamientos erróneos." & vbCrLf & _
        "- Análisis Comparativo: Comparar resultados de pruebas válidas vs. inválidas para asegurar robustez." & vbCrLf & _
        "- Reporte Final: Documentar hallazgos para futuras referencias y mejoras en compatibilidad."
    
    ' Slide 4: ACT2.8 - Título
    slideIndex = slideIndex + 1
    Set slide = pptPres.Slides.Add(slideIndex, 1)
    Set titleShape = slide.Shapes(1)
    titleShape.TextFrame.TextRange.Text = "ACT2.8: Implementación de Cambios con Documentación de Migración"
    Set contentShape = slide.Shapes(2)
    contentShape.TextFrame.TextRange.Text = "Proceso de documentación y validación: Migrar configuraciones deprecated, validar compatibilidad post-upgrade, documentar cambios y riesgos."
    
    ' Slide 5: ACT2.8 - Proceso de Documentación y Validación
    slideIndex = slideIndex + 1
    Set slide = pptPres.Slides.Add(slideIndex, 2)
    Set titleShape = slide.Shapes(1)
    titleShape.TextFrame.TextRange.Text = "Proceso de Documentación y Validación en ACT2.8"
    Set contentShape = slide.Shapes(2)
    contentShape.TextFrame.TextRange.Text = _
        "- Identificación de Deprecaciones: Documentar configuraciones obsoletas (ej. website en S3 bucket)." & vbCrLf & _
        "- Validación Inicial: Ejecutar terraform plan para identificar warnings y errores." & vbCrLf & _
        "- Migración de Provider: Actualizar versión y documentar cambios requeridos." & vbCrLf & _
        "- Corrección y Validación: Reemplazar bloques deprecated, re-ejecutar plan para confirmar eliminación de warnings." & vbCrLf & _
        "- Documentación de Migración: Registrar pasos, riesgos y estrategias para transiciones fluidas."
    
    ' Slide 6: Reflexiones ACT2.8
    slideIndex = slideIndex + 1
    Set slide = pptPres.Slides.Add(slideIndex, 2)
    Set titleShape = slide.Shapes(1)
    titleShape.TextFrame.TextRange.Text = "Reflexiones de ACT2.8"
    Set contentShape = slide.Shapes(2)
    contentShape.TextFrame.TextRange.Text = _
        "- Planificación cuidadosa para actualizaciones de módulos." & vbCrLf & _
        "- Documentación detallada y accesible." & vbCrLf & _
        "- Manejo de riesgos y transición fluida."
    
    ' Guardar la presentación
    Dim savePath As String
    savePath = "C:\Users\MA-Alumno\Documents\AUY1105-Infraestructura-como-codigo-II-1\EA2_ACT27_28_Presentation.pptx"
    pptPres.SaveAs savePath
    
    MsgBox "Presentación generada y guardada en: " & savePath
End Sub