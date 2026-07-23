  <section id="content" class="home clearfix">
<form id="checkoutAddress">
   <div class="container">
   <div class="row">
	   <div class="span12">
		   $Content
		  
	   </div>
   </div>
   <div class="row">
   <div class="span12">
   <h3>Ort auswählen*</h3>
				<p><small>Sie möchten die Tonnenreinigung an einem Ort nutzen, der nicht in der Liste steht? Rufen Sie uns an! Tel.: 0911 / 999 012 0</small></p>
			
			
				<select id="Location">
				<% loop $Locations.sort("SortOrder") %>
					<option value="$Title">$Title</option>
				<% end_loop %>
				</select>
				</div>
				</div>
        <div class="row">
		
		  <div class="span6">
		
		 <h3>Kontaktdaten:</h3>
				<div class="clearfix"></div>
				<p></p>
				<p><input type="radio" id="Firmenkunde" name="Kundenart" value="Firmenkunde" <% if $CheckoutAdress.Kundenart=="Firmenkunde" %>checked<% end_if %>> Firmenkunde*
				<input type="radio" id="Privatkunde" name="Kundenart" value="Privatkunde" <% if $CheckoutAdress.Kundenart=="Privatkunde" %>checked<% end_if %>> Privatkunde*</p>
				<div class="feld" style="float:none;">
					<label>Firmenname</label>
					<input type="text" name="Firmenname" value="$CheckoutAdress.Firmenname"/>					
				</div>
				<div class="feld">
					<label>Strasse/Nr*</label>
					<input  type="text" id="Strasse" name="Strasse" value="$CheckoutAdress.Strasse" />
				</div>
				<div class="feld last" >
					<label>PLZ*</label>
					<input type="text" id="PLZ"  name="PLZ" value="$CheckoutAdress.PLZ"/>
				</div>
				<div class="feld">
					<label>Ort*</label>
					<input type="text" id="Ort" name="Ort" value="$CheckoutAdress.Ort"/>
				</div>
				<div class="clearfix"></div>
				<h3 class="clearfix">Ansprechpartner</h3>
				<p><input type="radio" name="Anrede" value="Frau" <% if $CheckoutAdress.Anrede=="Frau" %>checked<% end_if %>> Frau*
				<input type="radio" name="Anrede" value="Herr" <% if $CheckoutAdress.Anrede=="Herr" %>checked<% end_if %>> Herr*</p>
				<div class="feld">
					<label>Nachname*</label>
					<input class="feld" type="text" id="Nachname" name="Nachname" value="$CheckoutAdress.Nachname"/>
				</div>
				<div class="feld last" >
					<label>Vorname*</label>
					<input class="feld last" type="text" id="Vorname" name="Vorname" value="$CheckoutAdress.Vorname"/>
				</div>
				<div class="feld">
					<label>Telefon*</label>
					<input class="feld" type="text" id="Telefon" name="Telefon" value="$CheckoutAdress.Telefon"/>
				</div>
				<div class="feld last" >
					<label>Email*</label>
					<input class="feld last" type="text" id="Email" name="Email" value="$CheckoutAdress.Email"/>
				</div>
          </div>
          <div class="span6">
		   <h3 class="clearfix">Zus&auml;tzliche Adressen</h3>
		   <br>
				<div class="feld">
				<label>Abweichende Reinigungsanschrift</label>
					<textarea id="reinigungsanschrift" name="reinigungsanschrift" cols="50" rows="4">$CheckoutAdress.reinigungsanschrift</textarea>
				</div>
				<div class="feld last" >
				<label>Abweichende Rechnungsanschrift</label>
					<textarea id="rechnungsanschrift" name="rechnungsanschrift" cols="50" rows="4">$CheckoutAdress.rechnungsanschrift</textarea>
				</div>
          </div>
		  
        </div>
		<div class="row">
		<div class="span6">
		<div id="config_zahlung">
				<h3>Zahlungsart ausw&auml;hlen:</h3>
				
				<p>
					Bitte haben Sie Verständnis, dass Aufträge von Privatkunden nur gegen Vorauskasse angenommen werden können.
				</p>
				<p>		
						<span id="Vorkasse"><input type="radio" id="Vorkasse" name="Zahlungsart"  value="Vorkasse" <% if $CheckoutAdress.Zahlungsart=="Vorkasse"  %>checked<% end_if %> > Vorkasse*</span>
						<% if $CheckoutAdress.Kundenart!="Privatkunde" %><span id="Rechnung"><input type="radio"  name="Zahlungsart"  value="Rechnung" <% if $CheckoutAdress.Zahlungsart=="Rechnung" %>checked<% end_if %>> Rechnung*</span><% end_if %>
					
				</p>
				
			</div>
		</div>
		</div>
		
		<div class="row">
		<div class="span12" id="message">
			
		</div>
   </div>
  
		<div class="row">
			<div class="span12">
				<a class="btn" href="javascript:checkoutAddress('$LinkCheckoutSummary','$Link')">Weiter zur Bestellübersicht</a>
				&nbsp;&nbsp;
				<a class="btn" href="$BaseHref$LinkBasket">Zur&uuml;ck zum Warenkorb</a>
			</div>
		</div>
		</div>  
    </form>
  </section>
