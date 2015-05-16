<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:swes="http://www.opengis.net/swes/2.0"
    xmlns:sos="http://www.opengis.net/sos/2.0" xmlns:swe="http://www.opengis.net/swe/1.0.1"
    xmlns:sml="http://www.opengis.net/sensorML/1.0.1" xmlns:gml="http://www.opengis.net/gml/3.2"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    exclude-result-prefixes="xs swes sos swe sml gml xlink xsi" version="2.0"
    xsi:schemaLocation="http://www.opengis.net/swes/2.0 http://schemas.opengis.net/swes/2.0/swes.xsd http://www.opengis.net/sos/2.0 http://schemas.opengis.net/sos/2.0/sosGetCapabilities.xsd http://www.opengis.net/gml/3.2 http://schemas.opengis.net/gml/3.2.1/gml.xsd">



    <xsl:output method="html" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>

    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html lang="en">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <meta name="description"
                    content="Human readable version of a sos capabilities - contents section - from getCapabilitites request"/>
                <meta name="author" content="Paolo Tagliolato"/>
                <meta name="author" content="Alessandro Oggioni"/>
                <link rel="icon" href="http://skmi.irea.cnr.it/static/geosk/img/favicon.ico"/>

                <title>Parameters of sensor</title>
                <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.css"/>

                <link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"
                    rel="stylesheet"/>

                <link
                    href="//cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/3.2.2/ekko-lightbox.min.css"
                    rel="stylesheet"/>

                <script src="http://code.jquery.com/jquery-1.11.1.min.js"/>

                <!--<script src="//code.jquery.com/jquery.js"/>-->
                <script src="http://rawgithub.com/ashleydw/lightbox/master/dist/ekko-lightbox.js"/>
                <script type="text/javascript">
                    $(document).ready(function ($) {
                    
                    // delegate calls to data-toggle="lightbox"
                    $(document).delegate('*[data-toggle="lightbox"]:not([data-gallery="navigateTo"])', 'click', function(event) {
                    event.preventDefault();
                    return $(this).ekkoLightbox({
                    onShown: function() {
                    if (window.console) {
                    return console.log('Checking our the events huh?');
                    }
                    },
                    onNavigate: function(direction, itemIndex) {
                    if (window.console) {
                    return console.log('Navigating '+direction+'. Current item: '+itemIndex);
                    }
                    }
                    });
                    });
                    
                    //Programatically call
                    $('#open-image').click(function (e) {
                    e.preventDefault();
                    $(this).ekkoLightbox();
                    });
                    $('#open-youtube').click(function (e) {
                    e.preventDefault();
                    $(this).ekkoLightbox();
                    });
                    
                    $(document).delegate('*[data-gallery="navigateTo"]', 'click', function(event) {
                    event.preventDefault();
                    return $(this).ekkoLightbox({
                    onShown: function() {
                    var a = this.modal_content.find('.modal-footer a');
                    if(a.length > 0) {
                    a.click(function(e) {
                    e.preventDefault();
                    this.navigateTo(2);
                    }.bind(this));
                    }
                    }
                    });
                    });
                    
                    });
                </script>

                <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"/>

            </head>

            <body>

                <div class="container">

                    <div class="row row-offcanvas row-offcanvas-right">

                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                            <div class="page-header">

                                <div class="page-header">
                                    <xsl:call-template name="sensorName"/>
                                </div>

                                <!--
                                <table class="table table-bordered table-striped">
                                    <xsl:for-each select="//sos:ObservationOffering">
                                        <xsl:if test="./sos:observedArea">
                                                <tr><td><xsl:value-of select="./sos:observedArea/gml:Envelope/gml:lowerCorner"/> </td>
                                                <td><xsl:value-of select="./sos:observedArea/gml:Envelope/gml:upperCorner"/> </td></tr>
                                        </xsl:if>
                                    </xsl:for-each>
                                </table>
                                -->

                                <div>
                                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                        <xsl:call-template name="sensorParams"/>
                                    </div>
                                </div>

                            </div>
                            <!--/row-->
                        </div>
                        <!--/span-->
                        <p>
                            <a href="http://sp7.irea.cnr.it/" role="button"
                                class="btn btn-success btn-mini pull-right" target="_blank"> How to
                                use this parameters </a>
                            <br/>
                        </p>


                    </div>
                    <!--/row-->

                </div>
                <!--/.container-->


                <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
                <script src="//getbootstrap.com/assets/js/ie10-viewport-bug-workaround.js"/>



            </body>
        </html>
    </xsl:template>

    <!-- sensorName tamplate -->
    <!-- THIS PART IS WILL BE FROM DescribeSensorResponse -->
    <xsl:template name="sensorName">
        <xsl:for-each
            select="swes:DescribeSensorResponse/swes:description/swes:SensorDescription/swes:data/sml:SensorML/sml:member/sml:System">
            <h1>
                <xsl:value-of select="gml:name"/>
                <xsl:text> </xsl:text>
                <xsl:if
                    test="sml:identification/sml:IdentifierList/sml:identifier[@name='Long Name']/sml:Term/sml:value">
                    <small>(<xsl:value-of
                            select="sml:identification/sml:IdentifierList/sml:identifier[@name='Long Name']/sml:Term/sml:value"
                        />)</small>
                </xsl:if>
            </h1>
            <xsl:if test="gml:description">
                <p>
                    <xsl:value-of select="gml:description"/>
                </p>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <!-- sensorParam template -->
    <xsl:template name="sensorParams">

        <xsl:for-each select="//sos:ObservationOffering">

            <!-- offering -->
            <h3>offering</h3>
            <p>
                <xsl:value-of select=".//swes:identifier"/>
            </p>
            <!-- observationType -->
            <h3>observationType</h3>
            <p>
                <xsl:value-of select=".//sos:observationType"/>
            </p>
            <!-- procedure -->
            <h3>procedure</h3>
            <p>
                <xsl:value-of select=".//swes:procedure"/>
            </p>
            <!-- observableProperties -->
            <h3>observableProperties</h3>
            <p>
                <xsl:for-each select="./swes:observableProperty">
                    <xsl:if test=".!='http://www.opengis.net/def/property/OGC/0/PhenomenonTime'">
                        <xsl:value-of select="."/>
                        <br/>
                        <strong>
                            <i>
                                <xsl:value-of select="document(.)//skos:prefLabel"/>
                            </i>
                        </strong>
                    </xsl:if>
                </xsl:for-each>
            </p>
            <!-- featureOfInterestType -->
            <h3>featureOfInterestType</h3>
            <p>
                <xsl:value-of select=".//sos:featureOfInterestType"/>
            </p>
            <!-- observedArea -->
            <h3>observedArea</h3>
            <p>
                <xsl:text>LowerCorner:</xsl:text>
                <xsl:value-of select="./sos:observedArea/gml:Envelope/gml:lowerCorner"/>
                <br/>
                <xsl:text>UpperCorner:</xsl:text>
                <xsl:value-of select="./sos:observedArea/gml:Envelope/gml:upperCorner"/>
            </p>
            <!-- FoI by getFeatureOfInterest here? -->
            <!-- observedArea -->
            <h3>phenomenonTime</h3>
            <p>
                <xsl:text>beginPosition:</xsl:text>
                <xsl:value-of select="./sos:phenomenonTime//gml:beginPosition"/>
                <br/>
                <xsl:text>endPosition:</xsl:text>
                <xsl:value-of select="./sos:phenomenonTime//gml:endPosition"/>
            </p>
            <!-- observedArea -->
            <h3>resultTime</h3>
            <p>
                <xsl:text>beginPosition:</xsl:text>
                <xsl:value-of select="./sos:resultTime//gml:beginPosition"/>
                <br/>
                <xsl:text>endPosition:</xsl:text>
                <xsl:value-of select="./sos:resultTime//gml:endPosition"/>
            </p>

        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
