package HL;
use Mojo::Base 'Mojolicious';
use Mojolicious::Static;

use Mojo::Pg;
use HL::Model::Pur;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');
  $self->secrets($self->config('secrets'));
  
  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer') if $config->{perldoc};

  # set static dir
  my $static = Mojolicious::Static->new;
  #push @{$static->paths}, '../public/'

  # for PUR Model
  $self->helper(pg => sub { state $pg = Mojo::Pg->new(shift->config('pg')) });
  $self->helper(
      purs => sub { state $purs = HL::Model::Pur->new(pg => shift->pg) });
  my $migrations = $self->home->child('migrations','pur.sql');
  $self->pg->auto_migrate(1)->migrations->name('pur')->from_file($migrations);
      
  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/' => sub { shift->redirect_to('pur') });
  $r->get('/pur')->to('pur#index');
  $r->get('/pur/export')->to('pur#export')->name('export_pur');
  $r->get('/pur/create')->to('pur#create')->name('create_pur');
  $r->get('/pur/list')->to('pur#list')->name('list_pur');
  $r->post('/pur')->to('pur#store')->name('store_pur');
  $r->get('/pur/:id')->to('pur#show')->name('show_pur');
  $r->get('/pur/:id/edit')->to('pur#edit')->name('edit_pur');
  $r->put('/pur/:id')->to('pur#update')->name('update_pur');
  $r->delete('/pur/:id')->to('pur#remove')->name('remove_pur');
}

1;
