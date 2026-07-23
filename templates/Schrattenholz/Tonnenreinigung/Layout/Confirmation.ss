<style>

.noBorder{
border:0;
}
h3, legend {
  font-size: 1.22em;
  font-weight: 400;
  line-height: 1.375em;
  margin-bottom: 0.6815em;
}
table {
  background-color: transparent;
  border-collapse: collapse;
  border-spacing: 0;
  max-width: 100%;
}
.table {
  margin-bottom: 20px;
  width: 100%;
}
.table th, .table td {
  border-top: 1px solid #dddddd;
  line-height: 20px;
  padding: 8px;
  text-align: left;
  vertical-align: top;
}
.table-striped tbody > tr:nth-child(2n+1) > td, .table-striped tbody > tr:nth-child(2n+1) > th {
  background-color: #f9f9f9;
}
.table-striped tbody tr:nth-child(2n+1) td, .table-striped tbody tr:nth-child(2n+1) th {
  background-color: #f5f5f5;
}
</style>
<h3>Guten Tag <% loop $Person %>$Anrede $Nachname<% end_loop %></h3>
<p>
folgende Bestellung ist soeben auf amp-bayern.com eingegangen:
</p>
<h3>Produkte auf der Bestellliste</h3>
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
		<h3>Ort der Reinigung: $CheckoutAdress.Location</h3>	
<h3>Angaben zum Auftraggeber</h3>
		
		 <div class="span4" style="margin-left:0;">
			<table class="table table-condensed">
				<thead>
				<tr>
				  <th>Kontaktdaten</th>
				  <th></th>
				  
				</tr>
			  </thead>
				<tbody>
					<tr><td width="20%">Kundenart:</td><td width="80%">$Kundenart</td></tr>
					<tr><td class="noBorder">Firmenname:</td><td>$CheckoutAdress.Firmenname</td></tr>
					<tr><td class="noBorder">Strasse:</td><td class="noBorder">$CheckoutAdress.Strasse</td></tr>
					<tr><td class="noBorder">PLZ:</td><td class="noBorder">$CheckoutAdress.PLZ</td></tr>
					<tr><td class="noBorder">Ort:</td><td class="noBorder">$CheckoutAdress.Ort</td></tr>
				</tbody>
			</table>
          </div>
          <div class="span4">
		  <table class="table table-condensed">
			<thead>
				<tr>
				  <th>Ansprechpartner</th>
				  <th></th>
				  
				</tr>
			  </thead>
				<tbody>
					<tr><td width="20%">Vorname:</td><td width="80%">$CheckoutAdress.Vorname</td></tr>
					<tr><td class="noBorder">Nachname:</td><td class="noBorder">$CheckoutAdress.Nachname</td></tr>
					<tr><td class="noBorder">Telefon:</td><td class="noBorder">$CheckoutAdress.Telefon</td></tr>
					<tr><td class="noBorder">Email:</td><td class="noBorder">$CheckoutAdress.Email</td></tr>
				</tbody>
			</table>

          </div>
<div class="span4">
		  <table class="table table-condensed">
			<thead>
				<tr>
				  <th>Abweichende Reinigungsanschrift</th>				  
				</tr>
			  </thead>
				<tbody>
					<tr><td>$CheckoutAdress.reinigungsanschrift</td></tr>
				</tbody>
			</table>
 <table class="table table-condensed">
			<thead>
				<tr>
				  <th>Abweichende Rechnungsanschrift</th>				  
				</tr>
			  </thead>
				<tbody>
					<tr><td>$CheckoutAdress.rechnungsanschrift</td></tr>
				</tbody>
			</table>
          </div>
		
		 
		 <div class="span12" style="margin-left:0;">
		 <h3>Zahlungsart: $CheckoutAdress.Zahlungsart</h3>
		</div>