package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

var withFrontend bool

var initCmd = &cobra.Command{
	Use:   "init <service-name>",
	Short: "Scaffold a new service",
	Long:  `Generates a fully deployable service scaffold including backend, IaC, CI/CD, and observability wiring.`,
	Args:  cobra.ExactArgs(1),
	RunE: func(cmd *cobra.Command, args []string) error {
		name := args[0]
		fmt.Printf("🚀 Initializing service: %s\n", name)
		if withFrontend {
			fmt.Println("   Frontend: React + Vite")
		} else {
			fmt.Println("   Frontend: static status page")
		}
		fmt.Println("   Backend:  Go + Chi")
		fmt.Println("   IaC:      OpenTofu (GCP)")
		fmt.Println("   Observability: Grafana Cloud")
		fmt.Println("\n(scaffold generation not yet implemented)")
		return nil
	},
}

func init() {
	initCmd.Flags().BoolVar(&withFrontend, "frontend", false, "Include a React + Vite frontend")
	rootCmd.AddCommand(initCmd)
}
