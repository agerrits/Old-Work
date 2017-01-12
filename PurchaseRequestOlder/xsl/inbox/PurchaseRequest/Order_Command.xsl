<xsl:stylesheet xmlns:aefe="http://schemas.active-endpoints.com/humanworkflow/2007/07/renderxsl/errors" xmlns:aefp="http://schemas.active-endpoints.com/humanworkflow/2007/07/renderxsl/formparams" xmlns:aemeta="urn:ae:xslrendering:meta" xmlns:aetc="http://schemas.active-endpoints.com/humanworkflow/2007/07/renderxsl/taskcommands" xmlns:ns="http://PurchaseRequest" xmlns:ns1="http://domain.com/purchaseFRequest/6" xmlns:trt="http://schemas.active-endpoints.com/b4p/wshumantask/2007/10/aeb4p-task-rt.xsd" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" aemeta:operation="purchaseRequest" aemeta:portType="ns1:rfq" aemeta:processName="ns:PurchaseRequest" aemeta:projectName="PurchaseRequest" aemeta:taskName="Order" aemeta:templateType="command" version="1.0">
   <!-- Import base stylesheets. -->
   <xsl:import href="urn:/aeb4p/rendering/xsl/ae_base_param2command.xsl"/>
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <!--  Override base template to process the work item form -->
   <xsl:template name="ae_workitem_param2command" xml:space="default">
      <xsl:choose>
         <xsl:when test="aefp:parameter[@name='aetaskworkitem_selection']/text()='_aesetoutput_'">
            <xsl:call-template name="ae_task_workitem_setoutput_part_purchaseRequestResponse"/>
         </xsl:when>
         <xsl:when test="aefp:parameter[@name='aetaskworkitem_selection']/text()='_aeclearfault_'">
            <xsl:call-template name="ae_workitem_clear_fault"/>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <!-- Template to clear fault. -->
   <xsl:template name="ae_workitem_clear_fault" xml:space="default">
      <xsl:call-template name="ae_deletefault_command">
         <xsl:with-param name="taskId" select="@taskId"/>
      </xsl:call-template>
   </xsl:template>
   <!--
			Set output part command templates 
		-->
   <!-- Set output part 'purchaseRequestResponse' -->
   <xsl:template xmlns:ns="http://domain.com/CheckResponse" name="ae_task_workitem_setoutput_part_purchaseRequestResponse" xml:space="default">
      <xsl:variable name="purchaseRequestResponse_ns_approved" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_approved']"/>
      <xsl:variable name="taskId">
         <xsl:value-of select="@taskId"/>
      </xsl:variable>
      <xsl:variable name="commandData">
         <ns:purchaseResponse xmlns:aem="urn:ae:xslrendering:meta" xmlns:ns2="http://domain.com/CheckResponse">
            <ns2:approved>
               <xsl:value-of select="$purchaseRequestResponse_ns_approved"/>
            </ns2:approved>
         </ns:purchaseResponse>
      </xsl:variable>
      <xsl:call-template name="ae_setoutputpart_command">
         <xsl:with-param name="taskId" select="$taskId"/>
         <xsl:with-param name="partName" select="'purchaseRequestResponse'"/>
         <xsl:with-param name="partData" select="$commandData"/>
      </xsl:call-template>
   </xsl:template>
</xsl:stylesheet>
