  <section id="content" class="home clearfix">
  <section>
   <div class="container">
        <div class="row">
		

		  <div class="span12">
		  
		  $Content
		  $Form
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
			  <th></th>
			  <th></th>
            </tr>
          </thead>
		   <tbody>
		  <% loop $Basket.Products %>
		  <tr>
				
				  <td>$id - $Title</td>
				  <td>$Wheels</td>
				  <td>$anz_tonnen</td>
				  <td>$anz_reinigungen</td>
				  <td>$Interval</td>
				  <td style="text-align: right;">$TotalPrice &euro;</td>
				  <td><a href="$Link" title="Produkt bearbeiten"><i style="font-size:1.2em;" class="icon-edit"></i></a></td>
				  <td><a href="javascript:removeProductFromBasket('$ID','{$Top.BaseHref}{$Top.Link}');" title="Produkt aus dem Warenkorb entfernen"><i style="font-size:1.2em;" class="icon-trash"></i></a></td>
				</tr>
		  <% end_loop %>
		  <tr>
				  <td></td>
				  <td></td>
				  <td></td>
				  <td></td>
				  <td style="text-align: right;">Preis gesamnt</td>
				  <td style="text-align: right;">$Basket.TotalPrice &euro;</td>
				  <td></td>
				  <td></td>
				</tr>
			<tr>
				  <td></td>
				  <td></td>
				  <td></td>
				  <td></td>
				  <td style="text-align: right;">zzgl. MwSt(19%)</td>
				  <td style="text-align: right;">$Basket.TotalTax &euro;</td>
				  <td></td>
				  <td></td>
			</tr>
			<tr> 
				  <td></td> 
				  <td></td>
				  <td></td>
				  <td></td>
				  <td style="text-align: right;">Brutto</td>
				  <td style="text-align: right;">$Basket.BruttoPrice &euro; </td>
				  <td></td>
				  <td></td>
			</tr>
		 </tbody>	 
        </table>
		<div class="row"><div class="span12"><a class="btn" href="{$BaseHref}$LinkCheckoutAddress">Zur Kasse</a>&nbsp;&nbsp;<a class="btn" href="javascript:clearBasket('{$Link}');">Warenkorb zurücksetzen</a></div></div>
		<% else %>
		<p>Es befinden sich momentan keine Produkte in Ihrem Warenkorb!</p>
		<a href="$LinkProductRoot">Zur Tonnen-&Uuml;bersicht</a>
		
		<% end_if %>
          </div>
          
        </div>
		</div>
    </section>
    

    
    
  </section>
  
  <script>
  
  function getTonne(){
		var tonnenObj={
			
				
					id:'$ID',
					wheels:'$Wheels',
					title:"$Title",
					anz_tonnen:jQuery("#anz_tonnen").val(),
					anz_reinigungen:jQuery("#anz_reinigungen").val(),
					zeit_woche:jQuery("#zeit_woche").val(),
					zeit_tag:jQuery("#zeit_tag").val(),
					preise:{<% loop $Preise %>$MinProductQuantity:"$Price",<% end_loop %>10000000:"0"}
				
			
			
		}
		return tonnenObj;	
	}
	function addToList(id){
		jQuery.ajax({
			url: "{$Link}/addToList?tonne="+JSON.stringify(getTonne()),
			success: function(data) {			
				dataAr=data.split("|");
				/*
					dataAr[0] = 0 -> error
					dataAr[0] = 1 -> ok
					dataAr[1] = error-code/product-number
				 */
				if(dataAr[0]!=0){
					$('#warenkorb_icon').html(dataAr[1]+'<span>Warenkorb</span>');
					console.log("id="+id+" wurde dem Warenkorb hinzugefügt");
				}else{
					if(dataAr[1]=="double"){
						console.log("id="+id+" das Produkt befindet sich bereits im Warenkorb");
					}else if(dataAr[1]=="validation"){
						console.log("id="+id+" Es fehlen Angaben zum Produkt");
					}					
				}
			}
		});
	}
	function getListCount(){
		jQuery.ajax({
			url: "{$Link}/getListCount",
			success: function(data) {
			if(parseInt(data)>0){
				$('#warenkorb_icon').html(data+'<span>Warenkorb</span>');
				}
			}
		});
	}
	
  </script>