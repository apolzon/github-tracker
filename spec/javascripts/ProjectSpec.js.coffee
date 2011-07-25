describe "Project Type", ->
  describe "when Pivotal is chosen as the type", ->
    beforeEach ->
      $("body").append("<form id='myform'><select id='myselect'><option value='val1'></select></form>")
      $("#myform").updateFormByType()
      $("#myselect").val("val1").change()

    it "requests the Pivotal form", ->
      request = mostRecentAjaxRequest()
      expect(request.method).toEqual("GET")
      expect(request.url).toMatch("/projects/val1")

    it "loads the returned content into the page", ->
      request = mostRecentAjaxRequest()
      response = {
        status: 200,
        responseText: JSON.stringify({content: "<form id='myform'>custom response</form>"})
      }
      request.response(response)

      expect($("#myform").html()).toMatch("custom response")
