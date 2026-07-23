 <section id="content" class="home clearfix">
 
   <div class="container">
        <div class="row">
		

		  <div class="span12">
		  
		  $Content
		  $Form
		  </div>
		  </div>
		  
		   <div class="row">
		

		  <div class="span12">
		  <% if $Basket.Products %>
		  <table class="table table-striped">
          <thead>
		 
            <tr>
              <th>Tonne</th>
              <th>R&auml;der</th>
              <th>Anzahl</th>
			   <th>Reinigungen / Jahr</th>
              <th>Intervall</th>
			  <th style="text-align: right;">Preis</th>
			
            </tr>
          </thead>
		   <tbody>
		  <% loop $Basket.Products %>
		  <tr>
				
				  <td>$Title</td>
				  <td>$Wheels</td>
				  <td>$anz_tonnen</td>
				  <td>$anz_reinigungen</td>
				  <td>$Interval</td>
				  <td style="text-align: right;">$TotalPrice &euro;</td>
				  
				</tr>
		  <% end_loop %>
		  <tr>
				  <td></td>
				  <td></td>
				  <td></td>
				  <td></td>
				  <td style="text-align: right;">Preis gesamnt</td>
				  <td style="text-align: right;">$Basket.TotalPrice &euro;</td>
				
				</tr>
			<tr>
				  <td></td>
				  <td></td>
				  <td></td>
				  <td></td>
				  <td style="text-align: right;">zzgl. MwSt(19%)</td>
				  <td style="text-align: right;">$Basket.TotalTax &euro;</td>
				 
			</tr>
			<tr>
				  <td></td>
				  <td></td>
				  <td></td>
				  <td></td>
				  <td style="text-align: right;">Brutto</td>
				  <td style="text-align: right;">$Basket.BruttoPrice &euro;</td>
				 
			</tr>
		 </tbody>	 
        </table>
		</div>
		</div>
		<div class="row">
				<div class="span12">
					<h3>Ort: $CheckoutAdress.Location</h3>
				</div>
			</div>
		<div class="row">
		
		  <div class="span6">
		<form id="checkoutAddress">
		 <h3>Kontaktdaten:</h3>
				<div class="clearfix"></div>
				<p></p>
				<p><input type="radio" id="Firmenkunde" name="Kundenart" <% if $CheckoutAdress.Kundenart=="Firmenkunde" %>checked<% end_if %> disabled value="Firmenkunde"> Firmenkunde*
				<input type="radio" id="Privatkunde" name="Kundenart" value="Privatkunde" <% if $CheckoutAdress.Kundenart=="Privatkunde" %>checked<% end_if %> disabled> Privatkunde*</p>
				<div class="feld" style="float:none;">
					<label>Firmenname</label>
					<input  type="text" id="Firmenname" name="Firmenname" disabled value="$CheckoutAdress.Firmenname"/>
				</div>
				<div class="feld">
					<label>Strasse/Nr*</label>
					<input  type="text" id="Strasse" name="Strasse" disabled value="$CheckoutAdress.Strasse" />
				</div>
				<div class="feld last" >
					<label>PLZ*</label>
					<input type="text" id="PLZ"  name="PLZ" disabled value="$CheckoutAdress.PLZ" />
				</div>
				<div class="feld">
					<label>Ort*</label>
					<input type="text" id="Ort" name="Ort" disabled value="$CheckoutAdress.Ort" />
				</div>
				<div class="clearfix"></div>
				<h3 class="clearfix">Ansprechpartner</h3>
				<p><input type="radio" name="Anrede" value="Frau" <% if $CheckoutAdress.Anrede=="Frau" %>checked<% end_if %> disabled > Frau*
				<input type="radio" name="Anrede" value="Herr" <% if $CheckoutAdress.Anrede=="Herr" %>checked<% end_if %> disabled > Herr*</p>
				<div class="feld">
					<label>Nachname*</label>
					<input class="feld" type="text" id="Nachname" name="Nachname" disabled value="$CheckoutAdress.Nachname" />
				</div>
				<div class="feld last" >
					<label>Vorname*</label>
					<input class="feld last" type="text" id="Vorname" name="Vorname" disabled value="$CheckoutAdress.Vorname" />
				</div>
				<div class="feld">
					<label>Telefon*</label>
					<input class="feld" type="text" id="Telefon" name="Telefon" disabled value="$CheckoutAdress.Telefon" />
				</div>
				<div class="feld last" >
					<label>Email*</label>
					<input class="feld last" type="text" id="Email" name="Email" disabled value="$CheckoutAdress.Email" />
				</div>
          </div>
          <div class="span6">
		   <h3 class="clearfix">Zus&auml;tzliche Adressen</h3>
		   <br>
				<div class="feld">
				<label>Abweichende Reinigungsanschrift</label>
					<textarea id="reinigungsanschrift" name="reinigungsanschrift" disabled cols="50" rows="4">$CheckoutAdress.reinigungsanschrift</textarea>
				</div>
				<div class="feld last" >
				<label>Abweichende Rechnungsanschrift</label>
					<textarea id="rechnungsanschrift" name="rechnungsanschrift" disabled cols="50" rows="4">$CheckoutAdress.rechnungsanschrift</textarea>
				</div>
          </div>
		  </form>
        </div>
		<div class="row">
		<div class="span6">
		<div id="config_zahlung">
				<h3>Zahlungsart</h3>
				
				
				<p>		
								
						<input type="radio" name="Zahlungsart"  value="Vorkasse" <% if $CheckoutAdress.Zahlungsart=="Vorkasse" %>checked<% end_if %> disabled> Vorkasse*
						<% if $Basket.TotalPriceFloat>50 %><input type="radio" name="Zahlungsart"  value="Rechnung" <% if $CheckoutAdress.Zahlungsart=="Rechnung" %>checked<% end_if %> disabled> Rechnung*<% end_if %>
					
				</p>
				
			</div>
			 <div class="span12" style="margin-left:0;">
		 
		 <p>
		 <input type="checkbox" name="agb" id="agb" style="margin-top:-2px" />
		 <span class="checkbox">Ich habe die <a href="{$BaseHref}$LinkAGB" >Allgemeinen Geschäftsbedingungen</a> gelesen und verstanden.</span>
		 </p>
		 <p>
		 <input type="checkbox" name="datenschutz" id="datenschutz" style="margin-top:-2px" />
		 <span class="checkbox">Ich stimme zu, dass meine Angaben aus dem Bestellprozess zur Bearbeitung meiner Bestellung erhoben und verarbeitet werden. Die Daten werden ausschließlich für die Bearbeitung der Bestellung und der dazu nötigen Prozesse verwendet.</span>
		 </p>
		 <p>Detaillierte Informationen zum Umgang mit Nutzerdaten finden Sie in unserer <a href="{$BaseHref}datenschutzerklärung" >Datenschutzerklärung</a>.</p>
	<input type="button" id="bestellenBtn" class="btn" value="Kostenpflichtig bestellen" disabled link="$BaseHref$LinkCheckoutFinal" />&nbsp;&nbsp;<a class="btn" href="$BaseHref$LinkCheckoutAddress">Zur&uuml;ck</a> 
	</div>
		</div>
		</div>
		
		<% else %>
		Es befinden sich momentan keine Produkte in Ihrem Warenkorb!
		
		<% end_if %>
          </div>
          
        </div>    
  </section>
  
  <script>
  var order="$BaseHref$LinkCheckoutFinal";
  var link="$Link";
  </script>
  