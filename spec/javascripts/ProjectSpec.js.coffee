describe "Project Type", ->
  beforeEach ->
    setFixtures("<form id='myform'><select id='myselect'><option value='val1'></select></form>")
    $("#myform").updateFormByType()

  describe "when Pivotal is chosen as the type", ->
    beforeEach ->
      $("#myselect").val("val1").change()

    it "loads the Pivotal form", ->
      request = mostRecentAjaxRequest()
      expect(request.method).toEqual("GET")
      expect(request.url).toMatch("/projects/val1")
