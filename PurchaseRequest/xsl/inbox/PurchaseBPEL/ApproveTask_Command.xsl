<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:aefp="http://schemas.active-endpoints.com/humanworkflow/2007/07/renderxsl/formparams"
                xmlns:aefe="http://schemas.active-endpoints.com/humanworkflow/2007/07/renderxsl/errors"
                xmlns:ns1="http://www.solazyme.com/RequestIn/HTA"
                xmlns:trt="http://schemas.active-endpoints.com/b4p/wshumantask/2007/10/aeb4p-task-rt.xsd"
                xmlns:ns="http://www.solazyme.com/RFQ/PurchaseBPEL"
                xmlns:aemeta="urn:ae:xslrendering:meta"
                xmlns:aetc="http://schemas.active-endpoints.com/humanworkflow/2007/07/renderxsl/taskcommands"
                aemeta:operation="PurRequestApprove"
                aemeta:portType="ns1:PurchaseApprovePT"
                aemeta:processName="ns:PurchaseBPEL"
                aemeta:projectName="PurchaseRequest"
                aemeta:taskName="ApproveTask"
                aemeta:templateType="command"
                version="1.0"><!-- Import base stylesheets. --><xsl:import href="urn:/aeb4p/rendering/xsl/ae_base_param2command.xsl"/>
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <!--  Override base template to process the work item form --><xsl:template name="ae_workitem_param2command" xml:space="default">
      <xsl:choose>
         <xsl:when test="aefp:parameter[@name='aetaskworkitem_selection']/text()='_aesetoutput_'">
            <xsl:call-template name="ae_task_workitem_setoutput_part_PurRequestApproveResponse"/>
         </xsl:when>
         <xsl:when test="aefp:parameter[@name='aetaskworkitem_selection']/text()='_aeclearfault_'">
            <xsl:call-template name="ae_workitem_clear_fault"/>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <!-- Template to clear fault. --><xsl:template name="ae_workitem_clear_fault" xml:space="default">
      <xsl:call-template name="ae_deletefault_command">
         <xsl:with-param name="taskId" select="@taskId"/>
      </xsl:call-template>
   </xsl:template>
   <!--
			Set output part command templates 
		--><!-- Set output part 'PurRequestApproveResponse' --><xsl:template xmlns:ns2="http://domain.com/purchaserequest"
                 xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                 name="ae_task_workitem_setoutput_part_PurRequestApproveResponse"
                 xml:space="default">
      <xsl:variable name="PurRequestApproveResponse_ns2_Approval"
                    select="//aefp:parameters/aefp:parameter[@name='PurRequestApproveResponse_ns2_Approval']"/>
      <xsl:variable name="taskId">
         <xsl:value-of select="@taskId"/>
      </xsl:variable>
      <xsl:variable name="commandData">
         <soapenv:Envelope xmlns:aem="urn:ae:xslrendering:meta">
            <soapenv:Header/>
            <soapenv:Body>
               <ns2:purchaseRequest>
                  <ns2:Header>
                     <ns2:Approval>
                        <xsl:value-of select="$PurRequestApproveResponse_ns2_Approval"/>
                     </ns2:Approval>
                  </ns2:Header>
               </ns2:purchaseRequest>
            </soapenv:Body>
         </soapenv:Envelope>
      </xsl:variable>
      <xsl:call-template name="ae_setoutputpart_command">
         <xsl:with-param name="taskId" select="$taskId"/>
         <xsl:with-param name="partName" select="'PurRequestApproveResponse'"/>
         <xsl:with-param name="partData" select="$commandData"/>
      </xsl:call-template>
   </xsl:template>
</xsl:stylesheet>