  <section id="content" class="home clearfix">
  <section>
   <div class="container">
        <div class="row">
		<% if WidgetsLinks %>
		<div class="span4">
		   
			   <% loop WidgetsLinks.Sort("SortOrder") %>
					$Content($Top.ID)
					<% if $Last==0 && $TotalItems!=1%><div style="border-bottom: 1px dotted; height: 20px; color: rgb(238, 238, 238); margin-bottom: 40px;"></div><% end_if %>
			   <% end_loop %>
		   
		   
          </div>
          <div class="span6">
		  <% else %>
		  <div class="span8">
		  <% end_if %>
		  <h1>Angaben zum Besteller - Bestellzusammenfassung - <span style="color: #99cc00;"><strong>BESTELLUNG</strong></span></h1>
<p>Vielen Dank f&uuml;r Ihre Bestellung.</p>
<p>Sie erhalten in K&uuml;rze eine Bestellbest&auml;tigung an die von Ihnen angegebene Email-Adresse $CheckoutAdress.Email</p>
<p>&nbsp;</p>
<p>Beste Gr&uuml;&szlig;e<br>das Team von amp-bayern.com</p>
		  $Form
          </div>
          <div class="span4">
		   <% if WidgetsRechts %>
		   
			   <% loop WidgetsRechts.Sort("SortOrder") %>
					$Content($Top.ID)
					
					<% if $Last %><% else %><div style="border-bottom: 1px dotted; height: 20px; color: rgb(238, 238, 238); margin-bottom: 40px;">&nbsp;</div><% end_if %>
			   <% end_loop %>
		   
		   <% end_if %>
          </div>
        </div>
		</div>
    </section>
    

    
    
  </section>
$ClearBasket
$ClearAddress