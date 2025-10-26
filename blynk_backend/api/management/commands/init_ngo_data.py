from django.core.management.base import BaseCommand
from api.models import NGOInfo

class Command(BaseCommand):
    help = 'Initialize NGO information for BEULYNK'

    def handle(self, *args, **kwargs):
        # Check if NGO info already exists
        if NGOInfo.objects.exists():
            self.stdout.write(self.style.WARNING('NGO information already exists'))
            return

        # Create NGO information
        ngo_info = NGOInfo.objects.create(
            name="BEULYNK",
            full_name="Beulah Humanity Reconciliation",
            tagline="Unity through connection",
            mission="BEULYNK is dedicated to fostering unity and connection among communities. Through innovative technology and compassionate outreach, we bridge gaps and create meaningful relationships that transform lives.",
            description="We are a non-profit organization committed to humanitarian work, community development, and social reconciliation. Our platform connects volunteers, donors, and communities to create lasting positive impact.",
            email="contact@beulynk.org",
            phone="+1 (555) 123-4567",
            address="Global Headquarters, Humanitarian District",
            facebook_url="https://facebook.com/beulynk",
            twitter_url="https://twitter.com/beulynk",
            instagram_url="https://instagram.com/beulynk",
            linkedin_url="https://linkedin.com/company/beulynk",
            lives_impacted=10000,
            active_donors=500,
            communities_served=50
        )

        self.stdout.write(self.style.SUCCESS(f'Successfully created NGO information: {ngo_info.name}'))

