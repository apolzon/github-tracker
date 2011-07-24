describe "Project Type", ->
  loadFixtures "project_type.html"
  $("#project").updateFormByType()

  describe "when Pivotal is chosen as the type", ->
    beforeEach ->
      $("#project_type").val("pivotal_project").change();

    it "loads the Pivotal form", ->
      expect(a).toBeTruthy()
