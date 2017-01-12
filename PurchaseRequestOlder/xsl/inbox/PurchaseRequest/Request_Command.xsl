<xsl:stylesheet xmlns:aefe="http://schemas.active-endpoints.com/humanworkflow/2007/07/renderxsl/errors" xmlns:aefp="http://schemas.active-endpoints.com/humanworkflow/2007/07/renderxsl/formparams" xmlns:aemeta="urn:ae:xslrendering:meta" xmlns:aetc="http://schemas.active-endpoints.com/humanworkflow/2007/07/renderxsl/taskcommands" xmlns:ns="http://PurchaseRequest" xmlns:ns1="http://domain.com/purchaseFRequest/1" xmlns:trt="http://schemas.active-endpoints.com/b4p/wshumantask/2007/10/aeb4p-task-rt.xsd" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" aemeta:operation="purchaseRequest" aemeta:portType="ns1:rfq" aemeta:processName="ns:PurchaseRequest" aemeta:projectName="PurchaseRequest" aemeta:taskName="Request" aemeta:templateType="command" version="1.0">
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
   <xsl:template xmlns:ns="http://domain.com/purchaserequest" name="ae_task_workitem_setoutput_part_purchaseRequestResponse" xml:space="default">
      <xsl:variable name="purchaseRequestResponse_ns_date" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_date']"/>
      <xsl:variable name="purchaseRequestResponse_ns_by" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_by']"/>
      <xsl:variable name="purchaseRequestResponse_ns_vendor" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_vendor']"/>
      <xsl:variable name="purchaseRequestResponse_ns_reason" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_reason']"/>
      <xsl:variable name="purchaseRequestResponse_ns_shipping" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_shipping']"/>
      <xsl:variable name="purchaseRequestResponse_ns_eta" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_eta']"/>
      <xsl:variable name="purchaseRequestResponse_ns_approved" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_approved']"/>
      <xsl:variable name="purchaseRequestResponse_ns_comments" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_comments']"/>
      <xsl:variable name="purchaseRequestResponse_ns_item_attr_LineNum" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_item_attr_LineNum']"/>
      <xsl:variable name="purchaseRequestResponse_ns_productNo" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_productNo']"/>
      <xsl:variable name="purchaseRequestResponse_ns_description" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_description']"/>
      <xsl:variable name="purchaseRequestResponse_ns_quantity" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_quantity']"/>
      <xsl:variable name="purchaseRequestResponse_ns_price" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_price']"/>
      <xsl:variable name="purchaseRequestResponse_ns_total" select="//aefp:parameters/aefp:parameter[@name='purchaseRequestResponse_ns_total']"/>
      <xsl:variable name="taskId">
         <xsl:value-of select="@taskId"/>
      </xsl:variable>
      <xsl:variable name="commandData">
         <ns:purchaseRequest xmlns:aem="urn:ae:xslrendering:meta">
            <ns1_0:Header xmlns:ns1_0="http://domain.com/purchaserequest">
               <ns1_0:date>
                  <xsl:value-of select="$purchaseRequestResponse_ns_date"/>
               </ns1_0:date>
               <ns1_0:by>
                  <xsl:value-of select="$purchaseRequestResponse_ns_by"/>
               </ns1_0:by>
               <ns1_0:vendor>
                  <xsl:value-of select="$purchaseRequestResponse_ns_vendor"/>
               </ns1_0:vendor>
               <ns1_0:reason>
                  <xsl:value-of select="$purchaseRequestResponse_ns_reason"/>
               </ns1_0:reason>
               <ns1_0:shipping>
                  <xsl:value-of select="$purchaseRequestResponse_ns_shipping"/>
               </ns1_0:shipping>
               <ns1_0:eta>
                  <xsl:value-of select="$purchaseRequestResponse_ns_eta"/>
               </ns1_0:eta>
               <ns1_0:approved>
                  <xsl:value-of select="$purchaseRequestResponse_ns_approved"/>
               </ns1_0:approved>
               <ns1_0:comments>
                  <xsl:value-of select="$purchaseRequestResponse_ns_comments"/>
               </ns1_0:comments>
            </ns1_0:Header>
            <ns1_0:Items xmlns:ns1_0="http://domain.com/purchaserequest">
               <ns1_0:item>
                  <xsl:attribute name="LineNum">
                     <xsl:value-of select="$purchaseRequestResponse_ns_item_attr_LineNum"/>
                  </xsl:attribute>
                  <ns1_0:productNo>
                     <xsl:value-of select="$purchaseRequestResponse_ns_productNo"/>
                  </ns1_0:productNo>
                  <ns1_0:description>
                     <xsl:value-of select="$purchaseRequestResponse_ns_description"/>
                  </ns1_0:description>
                  <ns1_0:quantity>
                     <xsl:value-of select="$purchaseRequestResponse_ns_quantity"/>
                  </ns1_0:quantity>
                  <ns1_0:price>
                     <xsl:value-of select="$purchaseRequestResponse_ns_price"/>
                  </ns1_0:price>
                  <ns1_0:total>
                     <xsl:value-of select="$purchaseRequestResponse_ns_total"/>
                  </ns1_0:total>
               </ns1_0:item>
            </ns1_0:Items>
         </ns:purchaseRequest>
      </xsl:variable>
      <xsl:call-template name="ae_setoutputpart_command">
         <xsl:with-param name="taskId" select="$taskId"/>
         <xsl:with-param name="partName" select="'purchaseRequestResponse'"/>
         <xsl:with-param name="partData" select="$commandData"/>
      </xsl:call-template>
   </xsl:template>
</xsl:stylesheet>
