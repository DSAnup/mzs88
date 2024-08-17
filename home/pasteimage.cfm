<cfoutput>
    
    <cfquery datasource="#request.dsnameReader#" name="qpasteImageSelect"> 
        select *
          from pasteImage 
        order by id desc
    </cfquery>
   
  <!-- main-container start -->
    <!-- ================ -->
    <section class="main-container">
    
        <div class="container">
    
            <!-- main start -->
            <!-- ================ -->
            <div class="main col-md-12">

                <!-- page-title start -->
                <!-- ================ -->
                
                <div class="row">
                    <div class="col-md-7">
                        <h1 class="page-title margin-top-clear"> Apply For Scholarship</h1>
                    </div>
                    <div class="col-md-4">
                        
                    </div>
                </div>
                <!-- page-title end -->
                <div class="space"></div>                    
                
                
    
                    <div class="row">
                        <div class="col-md-12">    
                        <p>Please complete the following details to apply scholarship</p>
                    </div>
                </div>

                <div id="pasteArea" contenteditable="false" style="width:100%; min-height:200px; border: 1px solid black;">
                    Paste your content here...
                </div>
                <div id="preview"></div>
                <form action="index.cfm?area=home&action=pasteImageAction" method="post" enctype="multipart/form-data" id="validate-1" role="form" class="form-horizontal">
                    <input type="hidden" name="imageData" id="imageData">
                    <input type="submit" value="Upload Image">
                </form>
                
            <div class="row">
                <div class="col-12">
                    <cfoutput>
                        <div class="table-responsive">
                            <table id="datatable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                            
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Image</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                <cfloop query="qpasteImageSelect">
                                    <tr>
                                        <td>#qpasteImageSelect.CurrentRow#</td>
                                        <td><img src="assets\alumni_pictures\pasteimage\#qpasteImageSelect.pasteImage#" style="width:200px; height:200px;" ></td>
                                    </tr>
                                </cfloop>

                                </tbody>
                            </table>
                        </div>		
                    </cfoutput>
                </div>
            </div>

            </div>
            
        </div>

    </section>
    <!-- main-container end -->
	
	    
    </cfoutput>
	<script language="javascript">    
        document.getElementById('pasteArea').addEventListener('paste', function (event) {
                    const items = event.clipboardData.items;
                    for (let i = 0; i < items.length; i++) {
                        if (items[i].type.indexOf('image') !== -1) {
                            const file = items[i].getAsFile();
                            const reader = new FileReader();
                            reader.onload = function (event) {
                                const img = new Image();
                                img.src = event.target.result;
                                document.getElementById('preview').appendChild(img);
                                document.getElementById('imageData').value = event.target.result;
                            };
                            reader.readAsDataURL(file);
                        }
                    }
                });

    </script>