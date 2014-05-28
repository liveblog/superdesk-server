Feature: News Items Archive

    @auth
    Scenario: List empty archive
        Given empty "archive"
        When we get "/archive"
        Then we get list with 0 items

    @wip
    @auth
    Scenario: Move item into archive
        Given empty "archive"
        And "ingest"
            """
            [{"guid": "tag:xyz-abc-123", "headline": "htext"}]
            """

        When we post to "/archive_ingest"
            """
            {
                "guid": "tag:xyz-abc-123"
            }
            """

        Then we get new resource
            """
            {"guid": "tag:xyz-abc-123"}
            """
        And we get "archived" in "ingest/tag:xyz-abc-123"

    @auth
    Scenario: Get archive item by guid
        Given "archive"
            """
            [{"guid": "tag:example.com,0000:newsml_BRE9A605"}]
            """

        When we get "/archive/tag:example.com,0000:newsml_BRE9A605"
        Then we get existing resource
            """
            {"guid": "tag:example.com,0000:newsml_BRE9A605"}
            """

    @auth
    Scenario: Update item
        Given "archive"
            """
            [{"_id": "xyz", "guid": "testid", "headline": "test"}]
            """

        When we patch "/archive/xyz"
            """
            {"slugline": "TEST", "urgency": 2, "version": "1"}
            """

        And we patch again
            """
            {"slugline": "TEST2", "version": "2"}
            """

        Then we get updated response
        And we get etag matching "/archive/xyz"
