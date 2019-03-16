<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.authoricon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
</div>

{% if theme.copyright %}
<div class="powered-by">
  {{ __('footer.powered', '<a class="theme-link" href="https://hexo.io">Hexo</a>') }}
</div>

<div class="theme-info">
  {{ __('footer.theme') }} -
  <a class="theme-link" href="https://github.com/iissnan/hexo-theme-next">
    NexT.{{ theme.scheme }}
  </a>
</div>
{% endif %}

<div class="beian">
	{% if config.beian.enable %}
		<a class="theme-link" href="http://www.miitbeian.gov.cn">{{ config.beian.icp }}</a>
	{% endif %}
	{% if config.gongan.enable %}
		{{' | '}}
		<span style="padding-left:25px;background:url(https://s1.ax1x.com/2018/09/29/ilmwIH.png) no-repeat left center" rel="nofollow">
		<a class="theme-link" href="'http://www.beian.gov.cn/portal/registerSystemInfo?recordcode='+config.gongan.num">
			{{ config.gongan.local+'公网安备'+config.gongan.num+'号' }}
		</a>
		</span>
	{% endif %}
</div>
