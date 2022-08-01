class ProfilesController<ApplicationController
    def show
        @profile=User.find(params[:id])
    end

    def friendlist
        @profile=User.find(params[:id])
    end

end