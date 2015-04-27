window.loadAndCompileFixture = (fixture, preCompileCallback) ->
  loadFixtures fixture

  preCompileCallback() if preCompileCallback?
  inject ($compile, $rootScope) ->
    $compile($('#teaspoon-fixtures'))($rootScope)
    $rootScope.$digest()
    init()

window.setAndCompileFixture = (fixtureString, preCompileCallback) ->
  setFixtures fixtureString
  preCompileCallback() if preCompileCallback?
  inject ($compile, $rootScope) ->
    $compile($('#teaspoon-fixtures'))($rootScope)
    $rootScope.$digest()
    init()

persistentTemplateCache = {}

window.preLoadTemplate = (templatePath) ->
  inject ($templateCache) ->
    templateUrl = "/search/assets/#{templatePath}"
    template = persistentTemplateCache[templateUrl]
    if template
      $templateCache.put templateUrl, template
      return
    $.ajax templateUrl,
      async: false
      cache: true
      success: (template) ->
        $templateCache.put templateUrl, template
        persistentTemplateCache[templateUrl] = template
      error: (xhr, status, error) ->
        throw "Error downloading template '#{templateUrl}'. Did you get the path right?"
