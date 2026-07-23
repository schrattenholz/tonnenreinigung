<section id="content" class="home clearfix">
   <div class="container">
		<div class="row">
			<div class="span4">
				<div class="imgWrapper"> <img src="$Bild.URL" alt="$Bild.Filename"/></div>
			</div>
			<div class="span8">
				<!--<nav id="projectsNav">
				  <ul class="pager">
					<li><a href=""><i class="icon-left-open-mini"></i>&nbsp;Previous</a></li>
					<li><a href="">Next&nbsp;<i class="icon-right-open-mini"></i></a></li>
				  </ul>
				</nav>-->
				<h2 class="standardTitle"><span>$Title - $Wheels R&auml;der</span><span style="float:right;"><a href="$LinkProductRoot">Zur &Uuml;bersicht</a></h2>
				<form id="tonnen_config">
					<div class="row">
						<div class="span4">
										<div>
											<label>Anzahl der Tonnen</label>
											<input value="<% if $SingleProduct %>$SingleProduct().anz_tonnen<% else %>0<% end_if %>" style="height: 28px;line-height: 30px;padding-bottom: 0;padding-right: 0;padding-top: 0;" type="number" min="0" id="anz_tonnen" style="width:100%;" />
											
										</div>
										<div>
											<label>Reinigungen pro Jahr</label>
											<select id="anz_reinigungen"  style="width:100%;">
												<option value="no">0</option>
												<option value="1" >1</option>
												<option value="2" >2</option>
												<option value="3" >3</option>
												<option value="4" >4</option>
												<option value="5" >5</option>
												<option value="6" >6</option>
												<option value="12" >monatlich</option>
											</select>
											<script>document.getElementById('anz_reinigungen').value = '$SingleProduct.anz_reinigungen';</script>
										</div>
										<div>
											<label>Intervall der Leerung</label>
											<select id="zeit_woche"  style="width:100%;">
												<option value="no">Intervall</option>
												<option value="woechentlich">w&ouml;chentlich</option>
												<option value="zweiwoechentlichgerade">14-t&auml;gig gerade Woche</option>
												<option value="zweiwoechentlichungerade">14-t&auml;gig ungerade Woche</option>
												<% if $Title=='Papiertonne' || $Title=='DSD-Tonne' %><option value="monatlich">monatlich</option><% end_if %>
												<option value="nichtbekannt">nicht bekannt</option>
												
											</select>
											<script>document.getElementById('zeit_woche').value = '$SingleProduct.zeit_woche';</script>
										</div>
										<div>
											<label>Tag der Leerung</label>
											<select id="zeit_tag"  style="width:100%;">
												<option value="no">Tag</option>
												<option value="mo">Mo</option>
												<option value="di">Di</option>
												<option value="mi">Mi</option>
												<option value="do">Do</option>
												<option value="fr">Fr</option>
												<option value="nichtbekannt">nicht bekannt</option>
												
											</select>
											<script>document.getElementById('zeit_tag').value = '$SingleProduct.zeit_tag';</script>
										</div>
										
										
										
										
						</div>
						<div class="span4">
							Preistabelle
							<table class="table table-striped">
							<% loop $Preise %><tr><td><% if $Last %>ab $MinProductQuantity<% else %>bis $MaxProductQuantity<% end_if %>: $Price &euro;/Stk.*</td></tr><% end_loop %>
							</table>
							*Alle Preise verstehen sich zzgl. der gesetzlichen Mehrwertsteuer von 19%.
						</div>
						
					</div>	
					<div class="row">
							<div class="span4"></div><div class="span8">				
											
											<div id="editFunction" <% if $SingleProduct %><% else %>style="display:none;"<% end_if %>>
												<a class="btn" href="javascript:addToList('$ID','edit');" title="Die alte Auswahl im Warenkorb wird mit der neuen Auswahl &uuml;berschrieben" ><i class="icon-basket" style="font-size:1.6em;"></i>
													<span class="i-name">Produkt aktualisieren</span>
												</a>
												<a class="btn btn-danger" href="javascript:javascript:removeProductFromBasket('$ID','{$Top.BaseHref}{$Top.Link}');" title="Produkt aus dem Warenkorb entfernen"><i class="icon-trash" style="font-size:1.6em;margin-right:0;" ></i>
													
												</a>
											</div>
											
											<div id="addFunction" <% if $SingleProduct %>style="display:none;"<% end_if %>>
												<a class="btn" href="javascript:addToList('$ID','new');"><i class="icon-basket" style="font-size:1.6em;"></i>
													<span class="i-name">In den Warenkorb</span>
												</a>
											</div>
											
											<br>
											<a href="$LinkBasket">Warenkorb &ouml;ffnen</a>&nbsp;|&nbsp;<a href="$LinkProductRoot">Weitere Tonne ausw&auml;hen</a>
										</div>
										</form>
							</div>
			
					</div>
        </div>
    </div>
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
	function addToList(id,action){
	console.log("addToList");
		jQuery.ajax({
		url: "{$Link}/addToList?tonne="+JSON.stringify(getTonne())+"&action="+action,
			success: function(data) {			
				dataAr=data.split("|");
				/*
					dataAr[0] = 0 -> error
					dataAr[0] = 1 -> ok
					dataAr[1] = error-code/product-number
				 */
				if(dataAr[0]!=0){
					$('#warenkorb_icon').html(dataAr[1]+'<span>Warenkorb</span>');
					//console.log("id="+id+" wurde dem Warenkorb hinzugefügt");
					$('#editFunction').css("display","block");
					$('#addFunction').css("display","none");
				}else{
					if(dataAr[1]=="double"){
						//console.log("id="+id+" das Produkt befindet sich bereits im Warenkorb");
					}else if(dataAr[1]=="validation"){
						//console.log("id="+id+" Es fehlen Angaben zum Produkt");
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
	function resetBasket(){
		jQuery.ajax({
			url: "{$Link}/resetList",
			success: function(data) {
				$('#warenkorb_icon').html('<span>Warenkorb</span>');
			}
		});
	}
</script>